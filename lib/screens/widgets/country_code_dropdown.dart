import 'package:flutter/material.dart';

class CountryCodeDropdown extends StatelessWidget {
  const CountryCodeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
                          value: '+91',
                          underline: const SizedBox(),
                          onChanged: (_) {
                          },
                          items: const [
                            DropdownMenuItem(value: '+91', child: Text('+91')),
                            
                          ],
                        );
  }
}