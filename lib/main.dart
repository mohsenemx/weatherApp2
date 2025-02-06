// ignore_for_file: avoid_print
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp22/data/classes.dart';
import 'package:weatherapp22/data/local.dart';
import 'package:weatherapp22/screens/main.dart';

Weather? weather;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initStorage();
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: WeatherApp(),
    ),
  );
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
