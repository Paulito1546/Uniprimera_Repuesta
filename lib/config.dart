import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';  // Pour Platform

const String LOCALTUNNEL_URL = 'https://uniprimer.loca.lt/sendmail';  // Ton URL principale, gardée telle quelle
const String EMULATOR_FALLBACK_URL = 'http://10.0.2.2:3000/sendmail';  // Optionnel : Fallback si issues sur émulateur

Future<String> getServerUrl() async {
  final deviceInfo = DeviceInfoPlugin();
  bool isPhysical = false;

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    isPhysical = androidInfo.isPhysicalDevice ?? false;
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    isPhysical = iosInfo.isPhysicalDevice ?? false;
  }

  // Log pour debug : Affiche dans la console si émulateur ou physique
  print('Exécution sur : ${isPhysical ? "appareil physique" : "émulateur/simulateur"}');

  // Par défaut, utilise LocalTunnel partout
  return LOCALTUNNEL_URL;

  // Optionnel : Si tu rencontres des issues sur émulateur, décommente ça pour fallback
  // return isPhysical ? LOCALTUNNEL_URL : EMULATOR_FALLBACK_URL;
}