import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp22/data/classes.dart';
import 'package:weatherapp22/data/local.dart';

class MainWeather extends StatelessWidget {
  final bool useFahrenheit;

  const MainWeather({super.key, this.useFahrenheit = false});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.currentWeather;

    if (weather == null) {
      return const Center(
        child: Text(
          "No weather data available",
          style: TextStyle(fontSize: 18, color: Colors.white70),
        ),
      );
    }

    double temperature = useFahrenheit
        ? (weather.temperature * 9 / 5) + 32
        : weather.temperature;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          getIconFromString(iconName: weather.state),
          size: 80,
          color: Colors.white,
        ),
        const SizedBox(height: 10),
        Text(
          weather.city.name,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(
          weather.state,
          style: const TextStyle(fontSize: 20, color: Colors.white70),
        ),
        const SizedBox(height: 5),
        Text(
          "${temperature.toStringAsFixed(1)}°${useFahrenheit ? 'F' : 'C'}",
          style: const TextStyle(
              fontSize: 48, fontWeight: FontWeight.w300, color: Colors.white),
        ),
      ],
    );
  }
}
