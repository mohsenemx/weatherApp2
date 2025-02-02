import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp22/data/classes.dart';
import 'package:weatherapp22/main.dart';

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

Future<Weather>? parseStorage() async {
  List<String>? raw = await prefs.getStringList('lastWeather');
  List<String>? rawLocation = await prefs.getStringList('locationData');
  if ((raw?.isEmpty ?? true) || (rawLocation?.isEmpty ?? true)) {
    throw NoDataException();
  }
  City city = City.fromList(rawLocation!);
  Weather lWeather = Weather.fromList(raw!, city);
  return lWeather;
}

Future<void> saveStorage() async {
  if (weather != null) {
    List<String> data = [
      weather!.temperature.toString(),
      weather!.state,
      weather!.feelsLike.toString(),
      weather!.lastUpdated.toString(),
      weather!.humidity.toString(),
      weather!.chanceOfRain.toString(),
      weather!.preasure.toString()
    ];
    List<String> cityData = City.toList(weather!.city);
    await prefs.setStringList('lastWeather', data);
    await prefs.setStringList('locationData', cityData);
  }
}

IconData getIconFromString({String iconName = 'Clear'}) {
  switch (iconName) {
    case 'Clear':
      return Icons.clear;
    default:
      return Icons.abc;
  }
}
