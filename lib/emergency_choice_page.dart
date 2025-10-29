import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'other_emergency_choice_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EmergencyChoice extends StatefulWidget {
  const EmergencyChoice({super.key});

  @override
  State<EmergencyChoice> createState() => EmergencyChoiceState();
}


class EmergencyChoiceState extends State<EmergencyChoice> {
  String? selectedType;

  final List<Map<String, dynamic>> emergencyTypes = [
    {'label': 'Electricidad', 'icon': '⚡', 'color': Colors.yellow},
    {'label': 'Químico', 'icon': '☢️', 'color': Colors.amber},
    {'label': 'Quemadura', 'icon': '🔥', 'color': Colors.orange},
    {'label': 'Otro', 'icon': '➕', 'color': Colors.red}
  ];

  Future<void> callNumber(String phoneNumber) async {
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
                    builder: (context) => OtherEmergencyDetailPage(),
                  ),
                );
              } else {
                final type = item['label'];
                try {
                  await sendEmergencyMail(type);    // Envoie le mail avec le type sélectionné
                  await callNumber("88888");         // Lance ensuite l’appel téléphone
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Erreur: $e")),
                  );
                }
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


Future<void> sendEmergencyMail(String emergencyType) async {
  final url = Uri.parse('http://10.0.2.2:3000/sendmail');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'subject': 'Alerte urgence',
      'text': "Type d'urgence signalé : $emergencyType"
    }),
  );
  if (response.statusCode != 200) {
    throw Exception('Échec envoi mail');
  }
}
