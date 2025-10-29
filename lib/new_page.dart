import 'package:flutter/material.dart';
import 'mail_request.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seconde Page'),
        leading: BackButton(), // bouton retour auto
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => sendMailFromFlutter(),
          child: const Text('Envoyer mail'),
        ),
      ),
    );
  }
}
