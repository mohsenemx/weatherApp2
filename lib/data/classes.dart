// ignore_for_file: prefer_initializing_formals
import 'package:flutter/material.dart';

class Weather {
  final double temperature;
  final double? tempMax;
  final double? tempMin;
  final String state;
  final double feelsLike;
  final double? pressure;
  final double? humidity;
  final double? chanceOfRain;
  final int sunset;
  final int sunrise;
  final int lastUpdated;
  final City city;
  final double? windSpeed;
  final int? windDeg;

  Weather({
    required this.temperature,
    this.tempMax,
    this.tempMin,
    required this.state,
    required this.feelsLike,
    this.pressure,
    this.humidity,
    this.chanceOfRain,
    required this.sunset,
    required this.sunrise,
    required this.lastUpdated,
    required this.city,
    this.windSpeed,
    this.windDeg,
  });

  /// Factory constructor to create a Weather instance from JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: (json['temperature'] as num).toDouble(),
      tempMax: json['temp_max'] != null
          ? (json['temp_max'] as num).toDouble()
          : null,
      tempMin: json['temp_min'] != null
          ? (json['temp_min'] as num).toDouble()
          : null,
      state: json['state'] as String,
      feelsLike: (json['feels_like'] as num).toDouble(),
      pressure: json['pressure'] != null
          ? (json['pressure'] as num).toDouble()
          : null,
      humidity: json['humidity'] != null
          ? (json['humidity'] as num).toDouble()
          : null,
      chanceOfRain: json['chance_of_rain'] != null
          ? (json['chance_of_rain'] as num).toDouble()
          : null,
      sunset: json['sunset'] as int,
      sunrise: json['sunrise'] as int,
      lastUpdated: json['last_updated'] as int,
      city: City.fromJson(json['city']),
      windSpeed: json['wind_speed'] != null
          ? (json['wind_speed'] as num).toDouble()
          : null,
      windDeg:
          json['wind_deg'] != null ? (json['wind_deg'] as num).toInt() : null,
    );
  }
  factory Weather.empty() {
    return Weather(
        temperature: -1000,
        state: '',
        feelsLike: -1000,
        sunset: 0,
        sunrise: 0,
        lastUpdated: 0,
        city: City.empty());
  }

  /// Converts Weather instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'temp_max': tempMax,
      'temp_min': tempMin,
      'state': state,
      'feels_like': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'chance_of_rain': chanceOfRain,
      'sunset': sunset,
      'sunrise': sunrise,
      'last_updated': lastUpdated,
      'city': city.toJson(),
      'wind_speed': windSpeed,
      'wind_deg': windDeg,
    };
  }

  /// Creates a new instance with updated values
  Weather copyWith({
    double? temperature,
    double? tempMax,
    double? tempMin,
    String? state,
    double? feelsLike,
    double? pressure,
    double? humidity,
    double? chanceOfRain,
    int? sunset,
    int? sunrise,
    int? lastUpdated,
    City? city,
    double? windSpeed,
    int? windDeg,
  }) {
    return Weather(
      temperature: temperature ?? this.temperature,
      tempMax: tempMax ?? this.tempMax,
      tempMin: tempMin ?? this.tempMin,
      state: state ?? this.state,
      feelsLike: feelsLike ?? this.feelsLike,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      chanceOfRain: chanceOfRain ?? this.chanceOfRain,
      sunset: sunset ?? this.sunset,
      sunrise: sunrise ?? this.sunrise,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      city: city ?? this.city,
      windSpeed: windSpeed ?? this.windSpeed,
      windDeg: windDeg ?? this.windDeg,
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
  factory City.empty() {
    return City(lat: 0, lon: 0, name: 'Somewhere', country: 'XX');
  }
}

class WeatherProvider with ChangeNotifier {
  Weather? _currentWeather;

  Weather? get currentWeather => _currentWeather;

  void updateWeather(Weather newWeather) {
    _currentWeather = newWeather;
    notifyListeners(); // Notify UI to rebuild
  }

  void updateCity(City city) {
    _currentWeather = _currentWeather!.copyWith(city: city);
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
