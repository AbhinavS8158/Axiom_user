import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/chat_list_controller.dart';
import 'package:user/screens/chat/chat.dart';

class ChatList extends StatelessWidget {
  final String currentUserId;

  ChatList({super.key, required this.currentUserId});

  final ChatListController controller = Get.put(ChatListController());

  @override
  Widget build(BuildContext context) {
    /// ✅ correct initialization
    controller.setUser(currentUserId);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.chats.isEmpty) {
          return const Center(child: Text("No conversations found"));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.chats.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final doc = controller.chats[index];
            final data = doc.data();
            final String providerId = data['providerId'];
            final String name = data['providerName'] ?? 'User';
            final String lastMessage = data['lastMessage'] ?? '';
            final String photo = data['providerImage'];
            final Timestamp? ts = data['lastMessageAt'];
            final String time =
                ts != null
                    ? TimeOfDay.fromDateTime(ts.toDate()).format(context)
                    : '';

            return ChatListTile(
              photo: photo,
              name: name,
              lastMessage: lastMessage,
              time: time,
              unreadCount: 0,
              onTap: () async {
                // 🔹 Mark chat as read / opened
                await FirebaseFirestore.instance
                    .collection('chats')
                    .doc(doc.id)
                    .update({
                      'lastOpenedBy': currentUserId,
                      'lastOpenedAt': FieldValue.serverTimestamp(),
                      'unreadCount_$currentUserId': 0, // optional pattern
                    });

                // 🔹 Navigate to chat screen
                Get.to(
                  () => Chat(
                    chatId: doc.id,
                    providerId: providerId,
                    providerName: name,
                    providerImg: photo,
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}

class ChatListTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final VoidCallback onTap;
  final String photo;

  const ChatListTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.onTap,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ---------------- AVATAR ----------------
            CircleAvatar(
              radius: 26,
              backgroundImage:
                  photo.isNotEmpty
                      ? NetworkImage(photo)
                      : const AssetImage('assets/avatar.png') as ImageProvider,
            ),

            const SizedBox(width: 12),

            // ---------------- MESSAGE INFO ----------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            // ---------------- TIME + UNREAD ----------------
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 6),
                if (unreadCount > 0)
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blue,
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
