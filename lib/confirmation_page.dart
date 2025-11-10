import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> report;
  final String emergencyType;

  const ConfirmationPage({
    super.key,
    required this.report,
    required this.emergencyType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icône de succès
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 120,
                ),
                const SizedBox(height: 32),

                // Titre
                const Text(
                  '¡Alerta enviada con éxito!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Sous-titre
                Text(
                  'Tipo de emergencia: $emergencyType',
                  style: const TextStyle(fontSize: 20, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Reportador: ${report['Ponente']}',
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(
                  'Víctima: ${report['Persona en situación de emergencia']}',
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 24),

                // Message de confirmation
                const Text(
                  'El equipo de emergencia ha sido notificado.\n'
                  'Se ha realizado una llamada al número de extensión 88888.\n'
                  '¡Gracias por tu rápida reacción!',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Bouton retour
                SizedBox(
                  width: 280,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      // Retour à l'écran principal (HomePage)
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text(
                      'Volver al inicio',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}