// lib/utils/date_utils.dart
DateTime getNextMonthPaymentDate(DateTime bookingDate) {
  final int year = bookingDate.year;
  final int month = bookingDate.month + 1;

  if (month > 12) {
    return DateTime(year + 1, 1, bookingDate.day);
  }

  return DateTime(year, month, bookingDate.day);
}
