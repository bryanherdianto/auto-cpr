/// Telemetry Data Models for OtoCPR
/// Representing real-time sensor streams from ESP32 Hub and Resusci Baby QCPR manikin,
/// as well as Edge AI diagnostics and system logs.
library;

class Esp32Telemetry {
  final double instantForce; // N
  final double peakForce; // N
  final double positionAngle; // Degrees (0-360)
  final double motorSpeed; // RPM
  final String direction; // 'CW' or 'CCW'
  final int compressionCount; // CYC
  final bool isConnected;
  final String deviceStatus; // 'Connected', 'Standby', 'Fault'
  final bool anomalyFlag;
  final DateTime timestamp;

  const Esp32Telemetry({
    this.instantForce = 68.5,
    this.peakForce = 94.2,
    this.positionAngle = 142.5,
    this.motorSpeed = 108.0,
    this.direction = 'CW',
    this.compressionCount = 842,
    this.isConnected = true,
    this.deviceStatus = 'Connected',
    this.anomalyFlag = false,
    required this.timestamp,
  });

  factory Esp32Telemetry.initial() {
    return Esp32Telemetry(timestamp: DateTime.now());
  }

  Esp32Telemetry copyWith({
    double? instantForce,
    double? peakForce,
    double? positionAngle,
    double? motorSpeed,
    String? direction,
    int? compressionCount,
    bool? isConnected,
    String? deviceStatus,
    bool? anomalyFlag,
    DateTime? timestamp,
  }) {
    return Esp32Telemetry(
      instantForce: instantForce ?? this.instantForce,
      peakForce: peakForce ?? this.peakForce,
      positionAngle: positionAngle ?? this.positionAngle,
      motorSpeed: motorSpeed ?? this.motorSpeed,
      direction: direction ?? this.direction,
      compressionCount: compressionCount ?? this.compressionCount,
      isConnected: isConnected ?? this.isConnected,
      deviceStatus: deviceStatus ?? this.deviceStatus,
      anomalyFlag: anomalyFlag ?? this.anomalyFlag,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'instant_force': instantForce,
        'peak_force': peakForce,
        'position_angle': positionAngle,
        'motor_speed': motorSpeed,
        'direction': direction,
        'compression_count': compressionCount,
        'is_connected': isConnected,
        'device_status': deviceStatus,
        'anomaly_flag': anomalyFlag,
        'timestamp': timestamp.toIso8601String(),
      };

  factory Esp32Telemetry.fromJson(Map<String, dynamic> json) {
    return Esp32Telemetry(
      instantForce: (json['instant_force'] as num?)?.toDouble() ?? 0.0,
      peakForce: (json['peak_force'] as num?)?.toDouble() ?? 0.0,
      positionAngle: (json['position_angle'] as num?)?.toDouble() ?? 0.0,
      motorSpeed: (json['motor_speed'] as num?)?.toDouble() ?? 0.0,
      direction: json['direction'] as String? ?? 'CW',
      compressionCount: json['compression_count'] as int? ?? 0,
      isConnected: json['is_connected'] as bool? ?? true,
      deviceStatus: json['device_status'] as String? ?? 'Connected',
      anomalyFlag: json['anomaly_flag'] as bool? ?? false,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }
}

class BabyQcprTelemetry {
  final double ventilationVolume; // ML
  final double compressionRate; // CPM
  final double compressionDepth; // CM
  final int compressionCount; // CYC
  final bool releaseOk; // Chest recoil flag
  final int breaths; // Total ventilations
  final bool isConnected;
  final DateTime timestamp;

  const BabyQcprTelemetry({
    this.ventilationVolume = 98.0,
    this.compressionRate = 94.2,
    this.compressionDepth = 4.7,
    this.compressionCount = 108,
    this.releaseOk = false,
    this.breaths = 28,
    this.isConnected = true,
    required this.timestamp,
  });

  factory BabyQcprTelemetry.initial() {
    return BabyQcprTelemetry(timestamp: DateTime.now());
  }

  BabyQcprTelemetry copyWith({
    double? ventilationVolume,
    double? compressionRate,
    double? compressionDepth,
    int? compressionCount,
    bool? releaseOk,
    int? breaths,
    bool? isConnected,
    DateTime? timestamp,
  }) {
    return BabyQcprTelemetry(
      ventilationVolume: ventilationVolume ?? this.ventilationVolume,
      compressionRate: compressionRate ?? this.compressionRate,
      compressionDepth: compressionDepth ?? this.compressionDepth,
      compressionCount: compressionCount ?? this.compressionCount,
      releaseOk: releaseOk ?? this.releaseOk,
      breaths: breaths ?? this.breaths,
      isConnected: isConnected ?? this.isConnected,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'ventilation_volume': ventilationVolume,
        'compression_rate': compressionRate,
        'compression_depth': compressionDepth,
        'compression_count': compressionCount,
        'release_ok': releaseOk,
        'breaths': breaths,
        'is_connected': isConnected,
        'timestamp': timestamp.toIso8601String(),
      };

  factory BabyQcprTelemetry.fromJson(Map<String, dynamic> json) {
    return BabyQcprTelemetry(
      ventilationVolume: (json['ventilation_volume'] as num?)?.toDouble() ?? 0.0,
      compressionRate: (json['compression_rate'] as num?)?.toDouble() ?? 0.0,
      compressionDepth: (json['compression_depth'] as num?)?.toDouble() ?? 0.0,
      compressionCount: json['compression_count'] as int? ?? 0,
      releaseOk: json['release_ok'] as bool? ?? false,
      breaths: json['breaths'] as int? ?? 0,
      isConnected: json['is_connected'] as bool? ?? true,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }
}

class AiDiagnosticsData {
  final double confidence; // e.g. 98.4
  final String classification;
  final String guidelineSubtitle;
  final String diagnosticInsight;
  final double tidalVolume; // ML
  final double strokeForce; // N
  final double recoilResidual; // N
  final double fatigueDrift; // %
  final double sessionHealthIndex; // %
  final String rawJson;

  const AiDiagnosticsData({
    this.confidence = 98.4,
    this.classification = 'Optimal Compression Dynamics',
    this.guidelineSubtitle = 'Pediatric rhythm & recoil thresholds verified',
    this.diagnosticInsight =
        'Current chest depression rate matches pediatric guideline AHA 2020 (100-120 CPM). Recoil pressure remains below the 0.5N residual resistance ceiling, maximizing coronary perfusion and avoiding barotrauma.',
    this.tidalVolume = 98.0,
    this.strokeForce = 94.2,
    this.recoilResidual = 0.2,
    this.fatigueDrift = 1.2,
    this.sessionHealthIndex = 99.2,
    required this.rawJson,
  });

  factory AiDiagnosticsData.initial() {
    return const AiDiagnosticsData(
      rawJson: '''{
  "timestamp": "2026-09-25T12:36:14Z",
  "device_id": "ESP32-C3-CARRIER-01",
  "model_version": "OtoCPR-Edge-v2.1",
  "inference": {
    "classification": "Optimal Compression Dynamics",
    "confidence": 0.984,
    "metrics": {
      "instant_force_N": 68.5,
      "peak_force_N": 94.2,
      "motor_rpm": 108.0,
      "shaft_angle_deg": 142.5,
      "ventilation_ml": 98.0,
      "recoil_ok": true
    },
    "anomaly_flag": false
  }
}''',
    );
  }

  AiDiagnosticsData copyWith({
    double? confidence,
    String? classification,
    String? guidelineSubtitle,
    String? diagnosticInsight,
    double? tidalVolume,
    double? strokeForce,
    double? recoilResidual,
    double? fatigueDrift,
    double? sessionHealthIndex,
    String? rawJson,
  }) {
    return AiDiagnosticsData(
      confidence: confidence ?? this.confidence,
      classification: classification ?? this.classification,
      guidelineSubtitle: guidelineSubtitle ?? this.guidelineSubtitle,
      diagnosticInsight: diagnosticInsight ?? this.diagnosticInsight,
      tidalVolume: tidalVolume ?? this.tidalVolume,
      strokeForce: strokeForce ?? this.strokeForce,
      recoilResidual: recoilResidual ?? this.recoilResidual,
      fatigueDrift: fatigueDrift ?? this.fatigueDrift,
      sessionHealthIndex: sessionHealthIndex ?? this.sessionHealthIndex,
      rawJson: rawJson ?? this.rawJson,
    );
  }
}

class DeviceLocationData {
  final double latitude;
  final double longitude;
  final bool isGpsLocked;
  final String locationLabel;

  const DeviceLocationData({
    this.latitude = -6.2088,
    this.longitude = 106.8456,
    this.isGpsLocked = false,
    this.locationLabel = 'Jakarta, Indonesia',
  });

  DeviceLocationData copyWith({
    double? latitude,
    double? longitude,
    bool? isGpsLocked,
    String? locationLabel,
  }) {
    return DeviceLocationData(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isGpsLocked: isGpsLocked ?? this.isGpsLocked,
      locationLabel: locationLabel ?? this.locationLabel,
    );
  }
}

class TelemetryLogItem {
  final String name;
  final String time;
  final String size;
  final String status;
  final bool isDerate;
  final String category; // 'ESP32', 'Baby QCPR', 'AI'
  final String preview;
  final String fullJson;

  const TelemetryLogItem({
    required this.name,
    required this.time,
    required this.size,
    required this.status,
    required this.isDerate,
    required this.category,
    required this.preview,
    required this.fullJson,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'time': time,
        'size': size,
        'status': status,
        'isDerate': isDerate,
        'category': category,
        'preview': preview,
        'fullJson': fullJson,
      };

  factory TelemetryLogItem.fromMap(Map<String, dynamic> map) {
    return TelemetryLogItem(
      name: map['name'] as String,
      time: map['time'] as String,
      size: map['size'] as String,
      status: map['status'] as String,
      isDerate: map['isDerate'] as bool,
      category: map['category'] as String? ?? 'ESP32',
      preview: map['preview'] as String,
      fullJson: map['fullJson'] as String? ?? map['preview'] as String,
    );
  }
}

class MetricHistorySeries {
  final String title;
  final String unit;
  final String currentValue;
  final String targetRange;
  final String meanValue;
  final String efficiency;
  final List<double> chartPoints;
  final String description;

  const MetricHistorySeries({
    required this.title,
    required this.unit,
    required this.currentValue,
    required this.targetRange,
    required this.meanValue,
    required this.efficiency,
    required this.chartPoints,
    required this.description,
  });
}
