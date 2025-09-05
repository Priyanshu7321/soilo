import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soilo/features/sensor/domain/entities/sensor_reading.dart';
import 'package:soilo/features/sensor/domain/repositories/sensor_repository.dart';

import '../providers/sensor_providers.dart';

/// Riverpod provider for SensorViewModel
final sensorViewModelProvider =
StateNotifierProvider<SensorViewModel, AsyncValue<SensorReading?>>(
      (ref) => SensorViewModel(
    sensorRepository: ref.watch(sensorRepositoryProvider),
  ),
);

/// StateNotifier that manages sensor data fetching
class SensorViewModel extends StateNotifier<AsyncValue<SensorReading?>> {
  final SensorRepository _sensorRepository;

  SensorViewModel({required SensorRepository sensorRepository})
      : _sensorRepository = sensorRepository,
        super(const AsyncValue.data(null));

  /// Fetch sensor data from repository
  Future<SensorReading> getSensorData() async {
    try {
      // always reset to loading before fetching
      state = const AsyncValue.loading();

      final reading = await _sensorRepository.getSensorData();

      // update state with data
      state = AsyncValue.data(reading);

      return reading;
    } catch (e, stackTrace) {
      // update state with error
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
