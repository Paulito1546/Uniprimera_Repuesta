import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';  

const String LOCALTUNNEL_URL = 'https://uniprimer.loca.lt/sendmail';  // My main URL
const String EMULATOR_FALLBACK_URL = 'http://10.0.2.2:3000/sendmail';  // Optional : Fallback if it's on emulator

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

  // Log for debug : Sgow in the console if emulator ou physical
  print('Execución sobre : ${isPhysical ? "Dispositivo físico" : "emulator/simulator"}');

  // By default, Localtunnal everywhere
  return LOCALTUNNEL_URL;
}