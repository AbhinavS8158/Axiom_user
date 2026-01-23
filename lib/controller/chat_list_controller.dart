import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final chats = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  final isLoading = true.obs;

  late final String currentUserId;
  StreamSubscription? _chatSub;

  /// Pass userId ONCE
  ChatListController(this.currentUserId);

  @override
  void onInit() {
    super.onInit();
    _listenChats(); // ✅ called once
  }

  void _listenChats() {
    isLoading.value = true;

    _chatSub = _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        chats.assignAll(snapshot.docs);
        isLoading.value = false;
      },
      onError: (_) {
        isLoading.value = false;
      },
    );
  }

  @override
  void onClose() {
    _chatSub?.cancel();
    super.onClose();
  }
}
