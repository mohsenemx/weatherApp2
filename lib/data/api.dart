// ignore_for_file: avoid_print, collection_methods_unrelated_type

import 'package:weatherapp2/data/classes.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:weatherapp2/data/secret.dart';

Future<Weather?> getWeather(String cityName) async {
  var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
      {'appid': OWPapiKey, 'q': cityName, 'units': 'metric'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    double? temp = jsonResponse['main']['temp'];
    double? feelsLike = jsonResponse['main']['feels_like'];
    String? main = jsonResponse['weather'][0]['main'];
    return Weather(
        temperature: temp ?? -1,
        state: main ?? 'E',
        feelsLike: feelsLike ?? -1,
        lastUpdated: '');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return null;
}

Future<List<String>?> searchCity(String text) async {
  // https://geocoding-api.open-meteo.com/v1/search?name=Berlin&count=10&language=en&format=json
  var url = Uri.https('geocoding-api.open-meteo.com', '/v1/search',
      {'name': text, 'count': 5, 'language': 'en', 'format': 'json'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var res = jsonResponse['results'];
    return res;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return [];
}

Future<Coordinate?> getCityCoordinate(
    {required String cityName, required String countryName}) async {
  // http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}
  var url = Uri.https('api.openweathermap.org', '/geo/1.0/direct',
      {'q': '$cityName,$countryName', 'appid': OWPapiKey, 'limit': '1'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return Coordinate(
        lat: jsonResponse[0]['lat'] ?? -1, lon: jsonResponse[0]['lon'] ?? -1);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return null;
}
