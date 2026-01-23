import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/model/messaging_model.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  late String chatId;
  bool _initialized = false;

  // ---------------- INIT CHAT ----------------
  Future<void> initChat({
    required String providerId,
    required String providerName,
    required String providerPhone,
    required String providerImage,
  }) async {
    if (_initialized) return;
    _initialized = true;

    final user = _auth.currentUser;
    if (user == null) return;

    final userId = user.uid;
    chatId = _generateChatId(userId, providerId);

    // 🔹 FETCH CURRENT USER DETAILS
    final userDoc =
        await _firestore.collection('users').doc(userId).get();

    final userData = userDoc.data() ?? {};

    final String userName = userData['name'] ?? '';
    final String userPhone = userData['phone'] ?? '';
    final String userImage = userData['profileImage'] ?? '';

    // 🔹 CREATE / UPDATE CHAT DOCUMENT
    await _firestore.collection('chats').doc(chatId).set({
      'providerId': providerId,
      'providerName': providerName,
      'providerPhone': providerPhone,
      'providerImage': providerImage,

      'userId': userId,
      'userName': userName,
      'userPhone': userPhone,
      'userImage': userImage,

      'participants': [userId, providerId],
      'lastMessage': '',
      'lastMessageAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    _listenMessages();
  }

  // ---------------- SEND MESSAGE ----------------
  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final userId = _auth.currentUser!.uid;
    messageController.clear();

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'text': text,
      'senderId': userId,
      'senderType': 'user',
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastMessageAt': FieldValue.serverTimestamp(),
    });
  }

  // ---------------- LISTEN MESSAGES ----------------
  void _listenMessages() {
    _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs.map((doc) {
        final data = doc.data();
         final Timestamp? ts = data['createdAt'];
        return ChatMessage(
          message: data['text'] ?? '',
          isMe: data['senderId'] == _auth.currentUser!.uid,
          time: ts != null ? ts.toDate() : DateTime.now(),
        );
      }).toList();
    });
  }

  // ---------------- CHAT ID ----------------
  String _generateChatId(String userId, String providerId) {
    return userId.compareTo(providerId) < 0
        ? '${userId}_$providerId'
        : '${providerId}_$userId';
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
