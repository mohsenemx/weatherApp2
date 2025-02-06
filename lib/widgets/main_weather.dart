import 'package:flutter/material.dart';
import 'package:weatherapp22/data/classes.dart';
import 'package:weatherapp22/data/local.dart';
import 'package:provider/provider.dart';

class MainWeather extends StatelessWidget {
  final bool useFahrenheit;

  const MainWeather({super.key, this.useFahrenheit = false});

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context);

    return Column(
      children: [
        Icon(getIconFromString(iconName: weather.currentWeather?.state)),
        Text(weather.currentWeather?.state ?? ''),
        Text(
          useFahrenheit
              ? '${(weather.currentWeather?.temperature ?? -1000 * 9 / 5 + 32).toStringAsFixed(1)}°F'
              : '${weather.currentWeather?.temperature.toStringAsFixed(1)}°C',
        ),
      ],
    );
  }
}
