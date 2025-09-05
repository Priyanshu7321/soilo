import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soilo/features/sensor/domain/entities/sensor_reading.dart';
import 'package:soilo/features/sensor/presentation/view_models/sensor_view_model.dart';

class SensorDisplay extends ConsumerWidget {
  const SensorDisplay({super.key});

  void _showSensorDataDialog(BuildContext context, SensorReading reading) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sensor Data'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDialogItem(
                '🌡️ Temperature',
                '${reading.temperature.toStringAsFixed(1)}°C',
              ),
              const SizedBox(height: 12),
              _buildDialogItem(
                '💧 Moisture',
                '${reading.moisture.toStringAsFixed(1)}%',
              ),
              const SizedBox(height: 8),
              Text(
                'Last updated: ${_formatTime(reading.timestamp)}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static Widget _buildDialogItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorState = ref.watch(sensorViewModelProvider);
    final sensorNotifier = ref.read(sensorViewModelProvider.notifier);

    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Soil Sensor Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Sensor data or placeholder
            sensorState.when(
              data: (reading) => reading != null
                  ? _buildSensorData(reading)
                  : const Text(
                  'No sensor data available. Tap "Get Sensor Data" to fetch.'),
              loading: () => const Text('Fetching latest data...'),
              error: (error, _) => Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(height: 24),

            // Action buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final reading = await sensorNotifier.getSensorData();
                        if (context.mounted) {
                          _showSensorDataDialog(context, reading);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    },
                    child: const Text('Get Sensor Data'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Button pressed - functionality coming soon!'),
                        ),
                      );
                    },
                    child: const Text('Action Button'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSensorData(SensorReading reading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSensorItem(
          icon: Icons.thermostat,
          label: 'Temperature',
          value: '${reading.temperature.toStringAsFixed(1)}°C',
          color: _getTemperatureColor(reading.temperature),
        ),
        const SizedBox(height: 12),
        _buildSensorItem(
          icon: Icons.water_drop,
          label: 'Moisture',
          value: '${reading.moisture.toStringAsFixed(1)}%',
          color: _getMoistureColor(reading.moisture),
        ),
        const SizedBox(height: 8),
        Text(
          'Last updated: ${_formatTime(reading.timestamp)}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  static Widget _buildSensorItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Color _getTemperatureColor(double temperature) {
    if (temperature < 10) return Colors.blue;
    if (temperature > 30) return Colors.red;
    return Colors.green;
  }

  static Color _getMoistureColor(double moisture) {
    if (moisture < 30) return Colors.orange;
    if (moisture > 70) return Colors.blue;
    return Colors.green;
  }

  static String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')} '
        '${time.hour >= 12 ? 'PM' : 'AM'}';
  }
}
