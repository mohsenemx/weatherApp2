import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp22/data/classes.dart';
import 'package:weatherapp22/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

String appVer = 'V0.1';
String changes = '''
Chnages
''';
late SharedPreferencesAsync prefs;
void initStorage() async {
  prefs = SharedPreferencesAsync();
  String? lastVer = await prefs.getString('appVer');
  if (lastVer != appVer) {
    // Do something
  }
}

Future<Weather> parseStorage() async {
  String? raw = await prefs.getString('lastWeather');
  if (raw == null) throw NoDataException();

  Map<String, dynamic> jsonData = jsonDecode(raw);
  return Weather.fromJson(jsonData);
}

Future<void> saveStorage() async {
  if (weather != null) {
    String jsonWeather = jsonEncode(weather!.toJson());
    await prefs.setString('lastWeather', jsonWeather);
  }
}

IconData getIconFromString({String? iconName = 'Clear'}) {
  switch (iconName) {
    case 'Clouds':
      return Icons.cloud;
    case 'Rain':
      return FontAwesomeIcons.cloudRain;
    case 'Snow':
      return Icons.ac_unit;
    case 'Thunderstorm':
      return Icons.flash_on;
    case 'Drizzle':
      return Icons.grain;
    case 'Mist':
    case 'Smoke':
    case 'Haze':
    case 'Dust':
    case 'Fog':
    case 'Sand':
    case 'Ash':
      return Icons.blur_on;
    case 'Squall':
    case 'Tornado':
      return Icons.waves;
    case 'Clear':
    default:
      return Icons.wb_sunny;
  }
}
