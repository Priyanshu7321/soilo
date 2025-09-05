import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soilo/features/sensor/domain/entities/sensor_reading.dart';
import 'package:soilo/features/sensor/domain/repositories/sensor_repository.dart';

import '../providers/sensor_providers.dart';

final historyViewModelProvider = StreamProvider<List<SensorReading>>((ref) {
  final sensorRepository = ref.watch(sensorRepositoryProvider);
  return sensorRepository.getSensorHistory();
});
