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
  // Convert a Weather object to a string array
  static List<String> toList(Weather weather) {
    return [
      weather.temperature.toString(),
      weather.state,
      weather.feelsLike.toString(),
      weather.lastUpdated.toString(),
      weather.humidity.toString(),
      weather.chanceOfRain.toString(),
      weather.preasure.toString()
    ];
  }

  // Convert a string array to a Weather object
  factory Weather.fromList(List<String> data, City city) {
    return Weather(
        temperature: double.parse(data[0]),
        state: data[1],
        feelsLike: double.parse(data[2]),
        lastUpdated: int.parse(data[3]),
        humidity: double.tryParse(data[4]),
        chanceOfRain: double.tryParse(data[5]),
        preasure: double.tryParse(data[6]),
        city: city);
  }
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
  // Convert a City object to a string array
  static List<String> toList(City city) {
    return [
      city.lat.toString(),
      city.lon.toString(),
      city.name,
      city.country,
    ];
  }

  // Convert a string array to a City object
  factory City.fromList(List<String> data) {
    return City(
      lat: double.parse(data[0]),
      lon: double.parse(data[1]),
      name: data[2],
      country: data[3],
    );
  }
}

// Handling errors
class NoDataException implements Exception {
  final String message;
  NoDataException([this.message = "No data found."]);
  @override
  String toString() => message;
}
