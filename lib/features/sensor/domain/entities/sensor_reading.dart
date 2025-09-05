class SensorReading {
  final double temperature;
  final double moisture;
  final DateTime timestamp;

  SensorReading({
    required this.temperature,
    required this.moisture,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'moisture': moisture,
        'timestamp': timestamp.toIso8601String(),
      };

  factory SensorReading.fromJson(Map<String, dynamic> json) => SensorReading(
        temperature: (json['temperature'] as num).toDouble(),
        moisture: (json['moisture'] as num).toDouble(),
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}
