class Weather {
  Weather(
      {required double temperature,
      required String state,
      required double feelsLike,
      required lastUpdated,
      preasure,
      humidity,
      chanceOfRain});
}

class Coordinate {
  Coordinate({required double lat, required double lon});
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