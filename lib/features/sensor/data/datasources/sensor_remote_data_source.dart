import 'package:soilo/features/sensor/domain/entities/sensor_reading.dart';

abstract class SensorRemoteDataSource {
  Future<SensorReading> getSensorData();
}

class SensorRemoteDataSourceImpl implements SensorRemoteDataSource {
  @override
  Future<SensorReading> getSensorData() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Generate random values for temperature and moisture
    final random = DateTime.now().millisecondsSinceEpoch;
    final temperature = 15.0 + (random % 25); // Random temp between 15-40°C
    final moisture = 20.0 + (random % 80);     // Random moisture between 20-100%
    
    return SensorReading(
      temperature: temperature,
      moisture: moisture,
      timestamp: DateTime.now(),
    );
  }
}
