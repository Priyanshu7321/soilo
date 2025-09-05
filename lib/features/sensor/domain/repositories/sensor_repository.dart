import 'package:soilo/features/sensor/domain/entities/sensor_reading.dart';

abstract class SensorRepository {
  Future<SensorReading> getSensorData();
  Stream<List<SensorReading>> getSensorHistory();
}
