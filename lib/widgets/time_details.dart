import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherapp22/data/classes.dart';

class TimeDetails extends StatelessWidget {
  final Weather weather;

  const TimeDetails({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    String sunset =
        '${DateTime.fromMillisecondsSinceEpoch(weather.sunset).hour.toString().padLeft(2, '0')}:${DateTime.fromMillisecondsSinceEpoch(weather.sunset).minute.toString().padLeft(2, '0')}';
    String sunrise =
        '${DateTime.fromMillisecondsSinceEpoch(weather.sunrise).hour.toString().padLeft(2, '0')}:${DateTime.fromMillisecondsSinceEpoch(weather.sunrise).minute.toString().padLeft(2, '0')}';
    String lastUpdated =
        '${DateTime.fromMillisecondsSinceEpoch(weather.lastUpdated).hour.toString().padLeft(2, '0')}:${DateTime.fromMillisecondsSinceEpoch(weather.lastUpdated).minute.toString().padLeft(2, '0')}';
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blueGrey[800],
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDetailRow(FontAwesomeIcons.sun, "Sunrise", sunrise),
            _buildDetailRow(FontAwesomeIcons.sun, "Sunset", sunset),
            _buildDetailRow(
                FontAwesomeIcons.clock, "Last Updated", lastUpdated),
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
