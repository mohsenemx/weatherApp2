import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp2/data/classes.dart';

String appVer = 'V0.1';
String changes = '''
Chnages
''';
late SharedPreferencesAsync prefs;
late Weather weather;
String? cityName;
String? countryCode;
void initStorage() async {
  prefs = SharedPreferencesAsync();
  String? lastVer = await prefs.getString('appVer');
  if (lastVer != appVer) {
    // Do something
  }
}

Future<Weather>? parseStorage() async {
  String? raw = await prefs.getString('lastWeather');
  List<String> splited = raw?.split(';') ?? [];
  if (splited.isEmpty) {
    throw NoDataException();
  }
  Weather lWeather = Weather(
      temperature: double.parse(splited[0]),
      state: splited[1],
      feelsLike: double.parse(splited[2]),
      lastUpdated: int.parse(splited[3]));
  return lWeather;
}
