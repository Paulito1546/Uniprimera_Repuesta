import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'emergency_choice_page.dart';
import 'dart:convert';
import 'confirmation_page.dart';

class QuestionnairePage extends StatefulWidget {
  final String emergencyType;

  const QuestionnairePage({super.key, required this.emergencyType});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  bool? isSelfEmergency; // Sí: true, No: false
  bool? breathes; // For "¿Respira?"
  bool? unconscious; // For "¿Está inconsciente?"
  bool? coherent; // For "¿Responde de manera coherente?"
  final TextEditingController _descriptionController = TextEditingController();
  bool showDescription = false;
  bool showAdditionalQuestions = false;
  bool stoppedEarly = false;

  Future<Map<String, dynamic>> _buildReport() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString('first_name') ?? 'Desconocido'; 
    final lastName = prefs.getString('last_name') ?? 'Desconocido';
    final idNumber = prefs.getString('id_number') ?? 'Desconocido';

    String location = 'X';
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception('Servicio de localización desactivado'); 

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) throw Exception('Permiso denegado');
      }

      if (permission == LocationPermission.deniedForever) throw Exception('Permiso denegado permanentemente');

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      location = 'lat:${position.latitude}, long:${position.longitude}';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error de localización: $e'))); 
    }

    return {
      'Ponente': '$firstName $lastName',
      'Identidad': idNumber,
      'Persona en situación de emergencia': isSelfEmergency == true ? 'yo' : 'otro',
      '¿Respira?': breathes == null ? 'X' : (breathes! ? 'Si' : 'No'),
      '¿Está inconsciente?': unconscious == null ? 'X' : (unconscious! ? 'Si' : 'No'),
      '¿Responde de manera coherente a preguntas sencillas?': coherent == null ? 'X' : (coherent! ? 'Si' : 'No'),
      'Más': _descriptionController.text.isEmpty ? 'X' : _descriptionController.text,
      'Localización': location,
      'Tipo': widget.emergencyType,
    };
  }

  void _handleFirstQuestion(bool answer) {
    setState(() {
      isSelfEmergency = answer;
      if (answer) {
        showDescription = true;
      } else {
        showAdditionalQuestions = true;
      }
    });
  }

  void _handleAdditionalQuestion(String question, bool answer) {
    setState(() {
      if (question == '¿Respira?') breathes = answer;
      if (question == '¿Está inconsciente?') unconscious = answer;
      if (question == '¿Responde de manera coherente a preguntas sencillas?') coherent = answer;

      if (answer) {
        stoppedEarly = true;
        showDescription = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cuestionario')), // Traduit
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSelfEmergency == null) ...[
              const Text('¿Soy yo la persona que tiene una emergencia?', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(onPressed: () => _handleFirstQuestion(true), child: const Text('Sí')),
                  const SizedBox(width: 16),
                  ElevatedButton(onPressed: () => _handleFirstQuestion(false), child: const Text('No')),
                ],
              ),
            ],
            if (showAdditionalQuestions && breathes == null && !stoppedEarly) ...[
              const SizedBox(height: 24),
              const Text('¿Respira?', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(onPressed: () => _handleAdditionalQuestion('¿Respira?', false), child: const Text('Sí')), 
                  const SizedBox(width: 16),
                  ElevatedButton(onPressed: () => _handleAdditionalQuestion('¿Respira?', true), child: const Text('No')),
                ],
              ),
            ],
            if (showAdditionalQuestions && breathes != null && unconscious == null && !stoppedEarly) ...[
              const SizedBox(height: 24),
              const Text('¿Está inconsciente?', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(onPressed: () => _handleAdditionalQuestion('¿Está inconsciente?', true), child: const Text('Sí')),
                  const SizedBox(width: 16),
                  ElevatedButton(onPressed: () => _handleAdditionalQuestion('¿Está inconsciente?', false), child: const Text('No')),
                ],
              ),
            ],
            if (showAdditionalQuestions && unconscious != null && coherent == null && !stoppedEarly) ...[
              const SizedBox(height: 24),
              const Text('¿Responde de manera coherente a preguntas sencillas?', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(onPressed: () => _handleAdditionalQuestion('¿Responde de manera coherente a preguntas sencillas?', true), child: const Text('Sí')),
                  const SizedBox(width: 16),
                  ElevatedButton(onPressed: () => _handleAdditionalQuestion('¿Responde de manera coherente a preguntas sencillas?', false), child: const Text('No')),
                ],
              ),
            ],
            if (showDescription || (coherent != null && !stoppedEarly)) ...[
              const SizedBox(height: 24),
              const Text('Especifique lo que sucedió (máx. 100 palabras):', style: TextStyle(fontSize: 18)), 
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                maxLength: 100,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (isSelfEmergency == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Responda a la primera pregunta'))); 
                    return;
                  }
                  try {
                    final report = await _buildReport();
                    await sendEmergencyReport(report);
                    await callNumber(context, "6013165000,88888");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationPage(
                          report: report,
                          emergencyType: widget.emergencyType,
                        ),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); 
                  }
                },
                child: const Text('Enviar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Future<void> callNumber(BuildContext context, String phoneNumber) async {
  final uri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Imposible abrir la aplicación de teléfono')), 
    );
  }
}