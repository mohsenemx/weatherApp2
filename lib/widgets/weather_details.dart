import 'package:flutter/material.dart';
import 'package:weatherapp22/data/classes.dart';

class WeatherDetails extends StatelessWidget {
  final Weather weather;

  const WeatherDetails({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blueGrey[800],
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDetailRow(
                Icons.thermostat, "Feels Like", "${weather.feelsLike}°"),
            _buildDetailRow(
                Icons.water_drop, "Humidity", "${weather.humidity}%"),
            _buildDetailRow(
                Icons.air, "Wind Speed", "${weather.windSpeed} km/h"),
            _buildDetailRow(
                Icons.compress, "Pressure", "${weather.pressure} hPa"),
            _buildDetailRow(
                Icons.umbrella, "Chance of Rain", "${weather.chanceOfRain}%"),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70),
              const SizedBox(width: 10),
              Text(label,
                  style: const TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
