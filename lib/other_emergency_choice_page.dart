import 'package:flutter/material.dart';
import 'questionnaire_page.dart';

class OtherEmergencyDetailPage extends StatelessWidget {
  const OtherEmergencyDetailPage({super.key});

  static const List<Map<String, dynamic>> otherTypes = [
    {'label': 'Caídas', 'icon': '⚠️'},
    {'label': 'Afección Cardíaca', 'icon': '❤️‍🩹'},
    {'label': 'Psicológicas', 'icon': '🧠'},
    {'label': 'Pérdida de conciencia', 'icon': '🤯'},
    {'label': 'Intoxicación por sustancias', 'icon': '💊'},
  ];

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionnairePage(emergencyType: item['label']),
                ),
              );
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