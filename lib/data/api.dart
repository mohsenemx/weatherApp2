// ignore_for_file: avoid_print, collection_methods_unrelated_type

import 'package:weatherapp22/data/classes.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:weatherapp22/data/secret.dart';

Future<Weather?> getWeather(City city) async {
  var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
      {'appid': OWPapiKey, 'q': city.name, 'units': 'metric'});
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('Got weather! for ${city.name}');
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      double? temp = jsonResponse['main']['temp'];
      double? feelsLike = jsonResponse['main']['feels_like'];
      String? main = jsonResponse['weather'][0]['main'];
      double? pressure = jsonResponse['main']['feels_like'];
      double? humidity = jsonResponse['main']['feels_like'];
      double? windSpeed = jsonResponse['wind']['speed'];
      int? windDeg = jsonResponse['wind']['deg'];
      double? chanceOfRain = jsonResponse['rain']['1h'];
      int? sunset = jsonResponse['sys']['sunset'];
      int? sunrise = jsonResponse['sys']['sunrise'];
      double? tempMin = jsonResponse['main']['temp_min'];
      double? tempMax = jsonResponse['main']['temp_max'];
      int? dt = jsonResponse['dt'];
      return Weather(
          temperature: temp ?? -1000,
          state: main ?? '',
          feelsLike: feelsLike ?? -1000,
          lastUpdated: dt ?? 0,
          chanceOfRain: chanceOfRain,
          humidity: humidity,
          pressure: pressure,
          tempMax: tempMax,
          tempMin: tempMin,
          windSpeed: windSpeed,
          windDeg: windDeg,
          sunset: sunset ?? 0,
          sunrise: sunrise ?? 0,
          city: city);
    } else {
      print(
          'Request failed with status: ${response.statusCode}, for city: ${city.name}.');
    }
  } catch (e) {
    print('Request failed with status: $e.');
    return null;
  }
  return null;
}

Future<List<City>> searchCity({required String text, int count = 5}) async {
  // https://geocoding-api.open-meteo.com/v1/search?name=Berlin&count=10&language=en&format=json
  var url = Uri.https('geocoding-api.open-meteo.com', '/v1/search',
      {'name': text, 'count': '$count', 'language': 'en', 'format': 'json'});
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var res = jsonResponse['results'];
      List<City> cities = [];
      for (int i = 0; i < res.length; i++) {
        City c = City(
            lat: res[i]['latitude'],
            lon: res[i]['longitude'],
            name: res[i]['name'],
            country: res[i]['country']);
        cities.add(c);
      }
      return cities;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('Request failed with status: $e.');
    return [];
  }
  return [];
}

Future<City?> getCityCoordinate(
    {required String cityName, required String countryName}) async {
  // http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}
  var url = Uri.https('api.openweathermap.org', '/geo/1.0/direct',
      {'q': '$cityName,$countryName', 'appid': OWPapiKey, 'limit': '1'});
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return City(
          lat: jsonResponse[0]['lat'] ?? -1,
          lon: jsonResponse[0]['lon'] ?? -1,
          name: 'a',
          country: 'd');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('Request failed with status: $e.');
    return null;
  }
  return null;
}
