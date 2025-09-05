import 'package:soilo/features/sensor/data/datasources/sensor_local_data_source.dart';
import 'package:soilo/features/sensor/data/datasources/sensor_remote_data_source.dart';
import 'package:soilo/features/sensor/domain/entities/sensor_reading.dart';
import 'package:soilo/features/sensor/domain/repositories/sensor_repository.dart';

class SensorRepositoryImpl implements SensorRepository {
  final SensorRemoteDataSource remoteDataSource;
  final SensorLocalDataSource localDataSource;

  SensorRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<SensorReading> getSensorData() async {
    try {
      // Get fresh data from the sensor/remote source
      final reading = await remoteDataSource.getSensorData();
      
      // Save the reading to local storage
      await localDataSource.saveReading(reading);
      
      return reading;
    } catch (e) {
      throw Exception('Failed to get sensor data: $e');
    }
  }
  
  @override
  Stream<List<SensorReading>> getSensorHistory() {
    try {
      return localDataSource.getReadings();
    } catch (e) {
      throw Exception('Failed to get sensor history: $e');
    }
  }
}
