import 'package:flutter/material.dart';
import 'main.dart';
import 'button_countdown.dart';

class AnonimoPage extends StatelessWidget {
  const AnonimoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          color: Colors.grey.shade400,
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Logo
          Image.asset('assets/logo.png', width: 150, height: 150),

          const SizedBox(height: 8),

          const SizedBox(height: 55),
          // Engrenage avec bouton rouge
          Center(
            child: CountdownButton(),
          ),

          const Spacer(),
          // Bouton ¿Qué hacer?
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SizedBox(
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {},
                child: const Text('¿Qué hacer?'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
