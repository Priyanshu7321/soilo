import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soilo/features/sensor/domain/entities/sensor_reading.dart';

class HistoryItem extends StatelessWidget {
  final SensorReading reading;

  const HistoryItem({
    super.key,
    required this.reading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSensorValue(
                  icon: Icons.thermostat,
                  value: '${reading.temperature.toStringAsFixed(1)}°C',
                  color: _getTemperatureColor(reading.temperature),
                ),
                _buildSensorValue(
                  icon: Icons.water_drop,
                  value: '${reading.moisture.toStringAsFixed(1)}%',
                  color: _getMoistureColor(reading.moisture),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _formatDate(reading.timestamp),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorValue({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getTemperatureColor(double temperature) {
    if (temperature < 10) return Colors.blue;
    if (temperature > 30) return Colors.red;
    return Colors.green;
  }

  Color _getMoistureColor(double moisture) {
    if (moisture < 30) return Colors.orange;
    if (moisture > 70) return Colors.blue;
    return Colors.green;
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, y • h:mm a').format(date);
  }
}
