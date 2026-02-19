import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/chat_controller.dart';
import 'package:user/model/messaging_model.dart';
import 'package:user/screens/chat/widget/chat_bubble.dart';
import 'package:user/screens/chat/widget/chat_input.dart';
import 'package:user/screens/utils/chat_date_helper.dart';

class Chat extends StatelessWidget {
  // ---------------- OPTIONAL PARAMETERS ----------------
  final String? chatId;
  final String? providerId;
  final String? providerName;
  final String? providerImg;
  final String? providerPhone;

  late final String chatTag;
  late final ChatController controller;

  Chat({
    super.key,
    this.chatId,
    this.providerId,
    this.providerName,
    this.providerImg,
    this.providerPhone,
  }) {
    /// ✅ Always use chatId if available, otherwise fallback
    chatTag = chatId ?? providerId ?? UniqueKey().toString();

    /// ✅ Create/Get controller with unique tag
    controller = Get.put(ChatController(), tag: chatTag);

    /// ✅ Initialize chat only when providerId exists
    if (providerId != null) {
      controller.initChat(
        // chatId: chatId ?? '',
        providerId: providerId!,
        providerName: providerName ?? 'User',
        providerPhone: providerPhone ?? '',
        providerImage: providerImg ?? '',
      );
    }

    debugPrint('Chat opened with tag: $chatTag');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage:
                  (providerImg != null && providerImg!.isNotEmpty)
                      ? NetworkImage(providerImg!)
                      : const AssetImage('assets/avatar.png') as ImageProvider,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  providerName ?? 'User',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Online',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),

      // ---------------- BODY ----------------
      body: Column(
        children: [
          // ---------------- MESSAGE LIST ----------------
          Expanded(
            child: Obx(() {
              if (controller.messages.isEmpty) {
                return const Center(
                  child: Text(
                    "Start the conversation",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final ChatMessage msg = controller.messages[index];
                  final bool showDate = ChatDateHelper.isNewDay(
                    index: index,
                    messageTimes:
                        controller.messages.map((m) => m.time).toList(),
                  );

                  return Column(
                    children: [
                      if (showDate)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                             ChatDateHelper.formatDate(msg.time),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),

                      ChatBubble(
                        message: msg.message,
                        isMe: msg.isMe,
                        time: TimeOfDay.fromDateTime(msg.time).format(context),
                      ),
                    ],
                  );
                },
              );
            }),
          ),

          // ---------------- INPUT ----------------
          ChatInput(controller: controller),
        ],
      ),
    );
  }
}
