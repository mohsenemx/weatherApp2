// ignore_for_file: prefer_initializing_formals
class Weather {
  double temperature;
  String state;
  double feelsLike;
  double? preasure;
  double? humidity;
  double? chanceOfRain;
  int lastUpdated;
  City city;
  Weather(
      {required this.temperature,
      required this.state,
      required this.feelsLike,
      required this.lastUpdated,
      required this.city,
      this.preasure,
      this.humidity,
      this.chanceOfRain});
}

class City {
  double lat;
  double lon;
  String name;
  String country;
  City(
      {required this.lat,
      required this.lon,
      required this.name,
      required this.country});
}

// Handling errors
class NoDataException {
  NoDataException();
}
/// 
/// city name
/// temperature
/// state 
/// feels like
/// last updated
/// 
/// preasure
/// humidity
/// chance of rain