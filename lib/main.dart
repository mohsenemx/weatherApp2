// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:weatherapp22/data/api.dart';
import 'package:weatherapp22/data/classes.dart';
import 'package:weatherapp22/data/local.dart';
import 'package:weatherapp22/screens/main.dart';

Weather? weather;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initStorage();
  List<City> cities = await searchCity(text: 'Sari');
  if (cities.isNotEmpty) {
    weather = await getWeather(cities[0]);
  }

  await saveStorage();
  Weather? a = await parseStorage();
  print(a!.state);
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}
