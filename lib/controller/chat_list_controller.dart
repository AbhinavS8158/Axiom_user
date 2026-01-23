import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final chats = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  final isLoading = true.obs;

  String? currentUserId;
  StreamSubscription? _chatSub;

  /// Call this from UI
  void setUser(String userId) {
    if (currentUserId == userId) return; // ✅ guard
    currentUserId = userId;
    _listenChats();
  }


  void _listenChats() {
    if (currentUserId == null) return;

    isLoading.value = true;
    _chatSub?.cancel();

    _chatSub = _firestore
        .collection('chats')
        // ✅ IMPORTANT: filter only this user's chats
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        chats.assignAll(snapshot.docs);
        isLoading.value = false;
      },
      onError: (e) {
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
