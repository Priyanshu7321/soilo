import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soilo/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:soilo/features/sensor/domain/entities/sensor_reading.dart';

abstract class SensorLocalDataSource {
  Future<void> saveReading(SensorReading reading);
  Stream<List<SensorReading>> getReadings();
}

class SensorLocalDataSourceImpl implements SensorLocalDataSource {
  final FirebaseFirestore _firestore;
  final Ref _ref;

  SensorLocalDataSourceImpl({
    required FirebaseFirestore firestore,
    required Ref ref,
  })  : _firestore = firestore,
        _ref = ref;

  String? get _userId => _ref.read(authStateChangesProvider).value?.uid;

  @override
  Future<void> saveReading(SensorReading reading) async {
    final userId = _userId;
    if (userId == null) throw Exception('User not authenticated');
    
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('sensor_readings')
        .add(reading.toJson());
  }

  @override
  Stream<List<SensorReading>> getReadings() {
    final userId = _userId;
    if (userId == null) throw Exception('User not authenticated');
    
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('sensor_readings')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                SensorReading.fromJson(doc.data()..['id'] = doc.id))
            .toList());
  }
}
