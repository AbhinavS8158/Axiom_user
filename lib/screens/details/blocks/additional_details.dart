import 'package:flutter/material.dart';
import 'package:user/screens/details/widgets/build_white_card.dart';

class AdditionalDetails extends StatelessWidget {
  final String bedrooms;
  final String bathrooms;
  final String powerBackup;
  final String furnished;
  const AdditionalDetails({
    super.key, 
    required this.bedrooms,
     required this.bathrooms,
     required this.powerBackup,
     required this.furnished,
     
     });

  @override
  Widget build(BuildContext context) {
    return  buildWhiteCard(
                      title: 'Additional Details',
                      child: Column(
                        children: [
                          _detailRow('Bedrooms', bedrooms),
                          const Divider(height: 24),
                          _detailRow('Bathroom', bathrooms),
                          const Divider(height: 24),
                          _detailRow('Power backup', powerBackup),
                          const Divider(height: 24),
                          _detailRow('furnished',furnished),
                        ],
                      ),
                    );
  }
}
  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }