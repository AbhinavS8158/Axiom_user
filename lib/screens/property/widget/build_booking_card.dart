import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/model/booking_model.dart';
import 'package:user/screens/home/widget/propertycard.dart';
import 'package:user/screens/utils/app_color.dart';
import 'package:user/screens/utils/date_utils.dart';

Widget buildBookingCard(property, Booking? booking) {
  final bool isSellProperty =
      property.collectiontype.toString().trim().toLowerCase() ==
      'sell_property';

  final String bookingDateText =
      booking != null ? DateFormat('dd MMM yyyy').format(booking.date) : 'N/A';
  final String nextPaymentDateText = booking != null
    ? DateFormat('dd MMM yyyy')
        .format(getNextMonthPaymentDate(booking.date))
    : 'N/A';

  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColor.black.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        PropertyCard(property: property),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColor.green50,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border(top: BorderSide(color: AppColor.grey2, width: 1)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: AppColor.green7, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Booking Confirmed',
                      style: TextStyle(
                        color: AppColor.green7,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(Icons.calendar_today, color: AppColor.green7, size: 18),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 13, color: AppColor.green7),
                      children: [
                        const TextSpan(text: 'Booking date: '),
                        TextSpan(
                          text: bookingDateText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: AppColor.green7, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 13, color: AppColor.green7),
                        children: [
                          const TextSpan(text: 'Next payment date: '),
                          TextSpan(
                            text: nextPaymentDateText,
                            style: const TextStyle(fontWeight: FontWeight.bold,color: AppColor.black),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                  if (!isSellProperty)
                    TextButton(
                      onPressed: () {
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColor.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text('Pay rent'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
