import 'package:flutter/material.dart';
import 'package:user/screens/booking/widgets/build_textfeild.dart';
import 'package:user/screens/booking/widgets/section_title.dart';

class AdditionalMessageSection extends StatelessWidget {
  final TextEditingController messageController;

  const AdditionalMessageSection({
    super.key,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle('Additional Message'),
        const SizedBox(height: 16),
        buildTextField(
          controller: messageController,
          label: 'Message (Optional)',
          icon: Icons.message_outlined,
          maxLines: 4,
        ),
      ],
    );
  }
}
