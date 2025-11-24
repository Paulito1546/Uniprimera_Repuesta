import 'package:flutter/material.dart';
import 'config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'other_emergency_choice_page.dart';
import 'questionnaire_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyChoice extends StatefulWidget {
  const EmergencyChoice({super.key});

  @override
  _EmergencyChoiceState createState() => _EmergencyChoiceState();
}

class _EmergencyChoiceState extends State<EmergencyChoice> {
  String? selectedType;

  final List<Map<String, dynamic>> emergencyTypes = [
    {'label': 'Electricidad', 'icon': '⚡', 'color': Colors.yellow},
    {'label': 'Químico', 'icon': '☢️', 'color': Colors.amber},
    {'label': 'Quemadura', 'icon': '🔥', 'color': Colors.orange},
    {'label': 'Otro', 'icon': '➕', 'color': Colors.red}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reporte'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'Al marcar el numero utiliza la ext. 88888',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ...emergencyTypes.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  selectedType = item['label'];
                });
                if (item['label'] == 'Otro') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtherEmergencyDetailPage(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionnairePage(emergencyType: item['label']),
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                  border: selectedType == item['label']
                      ? Border.all(color: Colors.purple, width: 3)
                      : null,
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
          )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.home, color: Colors.white, size: 32),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> sendEmergencyReport(Map<String, dynamic> report) async {
  final serverUrl = await getServerUrl();  // Get the URL con detection
  final url = Uri.parse(serverUrl);  
  print('Utilisation de l\'URL : $serverUrl');  // Log para verificar

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'to': 'paul.emptoz@gmail.com',  
      'subject': 'Alerta de urgencia',
      'text': jsonEncode(report),
    }),
  );

  print('Réponse serveur : Status ${response.statusCode} - Body: ${response.body}');  // Detailed log for errors

  if (response.statusCode != 200) {
    throw Exception('Échec envoi rapport : ${response.body}');
  }
}