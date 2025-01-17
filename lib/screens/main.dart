import 'package:flutter/material.dart';
import 'package:weatherapp22/main.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Text(weather?.state ?? ''),
          ),
        ),
      ),
    );
  }
}
