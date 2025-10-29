import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherEmergencyDetailPage extends StatelessWidget {
  const OtherEmergencyDetailPage({super.key});

  static const List<Map<String, dynamic>> otherTypes = [
    {'label': 'Caídas', 'icon': '⚠️'},
    {'label': 'Afección Cardíaca', 'icon': '❤️‍🩹'},
    {'label': 'Psicológicas', 'icon': '🧠'},
    {'label': 'Pérdida de conciencia', 'icon': '🤯'},
  ];

  Future<void> callNumber(BuildContext context, String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Impossible d'ouvrir l'application téléphone")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Especificar otro tipo')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: otherTypes.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: GestureDetector(
            onTap: () {
              // Appel direct après choix
              callNumber(context, "88888");
              // Tu peux aussi enregistrer le choix ici si besoin
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  Text(
                    item['icon'],
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    item['label'],
                    style: const TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}
