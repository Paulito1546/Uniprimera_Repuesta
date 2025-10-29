import 'package:flutter/material.dart';
import 'anonimo_page.dart';


void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uniprimer Respuesta',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Arial', // Tu peux personnaliser ici !
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo institutionnel (à remplacer par la bonne image)
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 8.0),
                  child: Image.asset(
                    'assets/logo.png', 
                    width: 200,
                    height: 200,
                  ),
                ),
                

                const SizedBox(height: 36),

                // Boutons rouges
                customButton('Estudiante UN', Colors.red, Colors.white, () {}),
                const SizedBox(height: 20),
                customButton('Anónimo', Colors.red, Colors.white, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AnonimoPage()),
                    );
                }),
                const SizedBox(height: 20),
                customButton('Externo', Colors.red, Colors.white, () {}),
                const SizedBox(height: 20),

                // Lien fictif/ligne pointillée (peut être remplacé par un Divider ou autre)
                Container(
                  width: 50,
                  height: 20,
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                  ),
                ),
                const SizedBox(height: 12),

                // Boutons noirs en bas
                customButton('Iniciar sesión', Colors.black, Colors.white, () {}),
                const SizedBox(height: 12),
                customButton('Registrarse', Colors.black, Colors.white, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fonction pour générer les boutons selon le style voulu
  Widget customButton(String text, Color bg, Color fg, void Function() onPressed) {
    return SizedBox(
      width: 320,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
          elevation: 2,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

// Ligne pointillée décorative
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double startX = 0.0;

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
