// ignore_for_file: prefer_initializing_formals
import 'package:flutter/material.dart';

class Weather {
  double temperature;
  String state;
  double feelsLike;
  double? pressure;
  double? humidity;
  double? chanceOfRain;
  int lastUpdated;
  City city;

  Weather({
    required this.temperature,
    required this.state,
    required this.feelsLike,
    required this.lastUpdated,
    required this.city,
    this.pressure,
    this.humidity,
    this.chanceOfRain,
  });

  // Convert Weather object to JSON
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'state': state,
      'feelsLike': feelsLike,
      'lastUpdated': lastUpdated,
      'humidity': humidity,
      'chanceOfRain': chanceOfRain,
      'pressure': pressure,
      'city': city.toJson(),
    };
  }

  // Create a Weather object from JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temperature'],
      state: json['state'],
      feelsLike: json['feelsLike'],
      lastUpdated: json['lastUpdated'],
      humidity: json['humidity'],
      chanceOfRain: json['chanceOfRain'],
      pressure: json['pressure'],
      city: City.fromJson(json['city']),
    );
  }
}

class City {
  double lat;
  double lon;
  String name;
  String country;

  City({
    required this.lat,
    required this.lon,
    required this.name,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
      'name': name,
      'country': country,
    };
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      lat: json['lat'],
      lon: json['lon'],
      name: json['name'],
      country: json['country'],
    );
  }
}

class WeatherProvider with ChangeNotifier {
  Weather? _currentWeather;

  Weather? get currentWeather => _currentWeather;

  void updateWeather(Weather newWeather) {
    _currentWeather = newWeather;
    notifyListeners(); // Notify UI to rebuild
  }
}

// Handling errors
class NoDataException implements Exception {
  final String message;
  NoDataException([this.message = "No data found."]);
  @override
  String toString() => message;
}
