import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp22/data/api.dart';
import 'package:weatherapp22/data/classes.dart';
import 'package:weatherapp22/widgets/main_weather.dart';
import 'package:weatherapp22/widgets/search.dart';
import 'package:weatherapp22/widgets/time_details.dart';
import 'package:weatherapp22/widgets/weather_details.dart'; // New widget for details

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
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    final Weather? currentWeather = weatherProvider.currentWeather;
    Weather? newWeather = await getWeather(
      currentWeather?.city ?? City.empty(),
    );

    if (!mounted) return;

    weatherProvider.updateWeather(newWeather ?? Weather.empty());

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.currentWeather;

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshWeather,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    weather?.city.name ?? "Fetching Location...",
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  _isLoading || weather == null
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            MainWeather(useFahrenheit: false),
                            WeatherDetails(
                                weather: weather), // Weather details widget
                            TimeDetails(weather: weather),
                            const SizedBox(height: 20),
                            SearchWidget(onCitySelected: (City selectedCity) {
                              weatherProvider.updateCity(selectedCity);
                            }),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
