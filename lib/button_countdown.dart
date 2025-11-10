import 'package:flutter/material.dart';
import 'emergency_choice_page.dart';

class SimpleEmergencyButton extends StatelessWidget {
  const SimpleEmergencyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EmergencyChoice()),
        );
      },
      child: Image.asset(
        'assets/buton.png',
        width: 350,
        height: 350,
      ),
    );
  }
}