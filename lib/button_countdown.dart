import 'dart:async';
import 'package:flutter/material.dart';
import 'new_page.dart';
import 'emergency_choice_page.dart';

class CountdownButton extends StatefulWidget {
  const CountdownButton({super.key});

  @override
  State<CountdownButton> createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> {
  int countdown = 3;
  Timer? timer;
  bool isPressed = false;

  void _startCountdown() {
    setState(() {
      isPressed = true;
      countdown = 3;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (countdown > 1) {
        setState(() {
          countdown -= 1;
        });
      } else {
        t.cancel();
        setState(() {
          countdown = 0;
          isPressed = false;
        });
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EmergencyChoice()),
        );
      }
    });
  }

  void _cancelCountdown() {
    timer?.cancel();
    setState(() {
      isPressed = false;
      countdown = 3;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _startCountdown(),
      onTapUp: (_) => _cancelCountdown(),
      onTapCancel: _cancelCountdown,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/buton.png',
            width: 350,
            height: 350,
          ),
          if (isPressed)
            Text(
              '$countdown',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black45,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
