import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendMailFromFlutter() async {
  final url = Uri.parse('http://10.0.2.2:3000/sendmail'); 
  
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'to': 'paul.emptoz@gmail.com',
      'subject': 'Sujet du mail',
      'text': 'Bonjour, ceci est un mail envoyé depuis Flutter via serveur local.',
    }),
  );

  if (response.statusCode == 200) {
    print('Mail envoyé avec succès');
  } else {
    print('Erreur lors de l’envoi : ${response.statusCode}');
  }
}
