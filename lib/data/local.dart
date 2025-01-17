import 'package:shared_preferences/shared_preferences.dart';
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
  City city = City(
      lat: double.parse(rawLocation![0]),
      lon: double.parse(rawLocation[1]),
      name: rawLocation[2],
      country: rawLocation[3]);
  Weather lWeather = Weather(
      temperature: double.parse(raw![0]),
      state: raw[1],
      feelsLike: double.parse(raw[2]),
      lastUpdated: int.parse(raw[3]),
      city: city);
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
    List<String> cityData = [
      weather!.city.lat.toString(),
      weather!.city.lon.toString(),
      weather!.city.name,
      weather!.city.country,
    ];
    await prefs.setStringList('lastWeather', data);
    await prefs.setStringList('locationData', cityData);
  }
}
