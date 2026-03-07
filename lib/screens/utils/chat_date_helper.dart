class ChatDateHelper {
  static bool isNewDay({
    required int index,
    required List<DateTime> messageTimes,
  }) {
    if (index == 0) return true;

    final current = messageTimes[index];
    final previous = messageTimes[index - 1];

    return current.year != previous.year ||
        current.month != previous.month ||
        current.day != previous.day;
  }

  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate =
        DateTime(date.year, date.month, date.day);

    if (messageDate == today) return "Today";
    if (messageDate == yesterday) return "Yesterday";

    return "${date.day.toString().padLeft(2, '0')} "
        "${_monthName(date.month)} "
        "${date.year}";
  }

  static String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];

    return months[month - 1];
  }
}
