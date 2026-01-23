import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/chat_controller.dart';
import 'package:user/model/messaging_model.dart';
import 'package:user/screens/chat/widget/chat_bubble.dart';
import 'package:user/screens/chat/widget/chat_input.dart';

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
  bool _isNewDay(int index, List<ChatMessage> messages) {
    if (index == 0) return true;

    final current = messages[index].time;
    final previous = messages[index - 1].time;

    return current.year != previous.year ||
        current.month != previous.month ||
        current.day != previous.day;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) return "Today";
    if (messageDate == yesterday) return "Yesterday";

    return "${date.day.toString().padLeft(2, '0')} "
        "${_monthName(date.month)} "
        "${date.year}";
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
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
                  final bool showDate = _isNewDay(index, controller.messages);

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
                              _formatDate(msg.time),
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
