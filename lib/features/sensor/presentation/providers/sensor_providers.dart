import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soilo/features/sensor/data/datasources/sensor_local_data_source.dart';
import 'package:soilo/features/sensor/data/datasources/sensor_remote_data_source.dart';
import 'package:soilo/features/sensor/data/repositories/sensor_repository_impl.dart';
import 'package:soilo/features/sensor/domain/repositories/sensor_repository.dart';

// Data Sources
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final sensorRemoteDataSourceProvider = Provider<SensorRemoteDataSource>(
  (ref) => SensorRemoteDataSourceImpl(),
);

final sensorLocalDataSourceProvider = Provider<SensorLocalDataSource>(
  (ref) => SensorLocalDataSourceImpl(
    firestore: ref.watch(firestoreProvider),
    ref: ref,
  ),
);

// Repository
final sensorRepositoryProvider = Provider<SensorRepository>(
  (ref) => SensorRepositoryImpl(
    remoteDataSource: ref.watch(sensorRemoteDataSourceProvider),
    localDataSource: ref.watch(sensorLocalDataSourceProvider),
  ),
);
