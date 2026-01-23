class ChatListItem {
  final String chatId;
  final String providerId;
  final String providerName;
  final String providerImage;
  final String lastMessage;
  final DateTime? lastMessageAt;

  ChatListItem({
    required this.chatId,
    required this.providerId,
    required this.providerName,
    required this.providerImage,
    required this.lastMessage,
    required this.lastMessageAt,
  });
}
