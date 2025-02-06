import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp22/data/api.dart';
import 'package:weatherapp22/data/classes.dart';
import 'package:weatherapp22/widgets/main_weather.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshWeather();
  }

  Future<void> _refreshWeather() async {
    Weather? newWeather = await getWeather(
      City(country: 'IR', name: 'Sari', lat: 1, lon: 1),
    );

    if (!mounted) return;

    Provider.of<WeatherProvider>(context, listen: false)
        .updateWeather(newWeather!);

    setState(() {
      _isLoading = false; // Stop loading after fetching weather
    });
  }

  @override
  Widget build(BuildContext context) {
    Weather? weather = Provider.of<WeatherProvider>(context).currentWeather;

    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshWeather,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 50),
              child: _isLoading || weather == null
                  ? const CircularProgressIndicator() // Show loading if data isn't ready
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainWeather(useFahrenheit: false),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
