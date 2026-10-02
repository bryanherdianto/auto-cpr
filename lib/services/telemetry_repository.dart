import 'package:flutter/foundation.dart';
import '../models/telemetry_models.dart';

/// Central Telemetry Repository for OtoCPR.
/// Acts as the single source of truth for hardware telemetry, AI inference,
/// device status, and machine logs.
///
/// UI components listen to these reactive notifiers instead of hardcoding values.
/// Ready for direct integration with Bluetooth LE, MQTT, WebSockets, or local SQLite/Drift database.
class TelemetryRepository {
  TelemetryRepository._();
  static final TelemetryRepository instance = TelemetryRepository._();

  // Reactive state notifiers
  final ValueNotifier<Esp32Telemetry> esp32Notifier = ValueNotifier(Esp32Telemetry.initial());
  final ValueNotifier<BabyQcprTelemetry> babyQcprNotifier = ValueNotifier(BabyQcprTelemetry.initial());
  final ValueNotifier<AiDiagnosticsData> aiDiagnosticsNotifier = ValueNotifier(AiDiagnosticsData.initial());
  final ValueNotifier<DeviceLocationData> locationNotifier = ValueNotifier(const DeviceLocationData());
  final ValueNotifier<List<TelemetryLogItem>> logsNotifier = ValueNotifier(_initialLogs);

  // Convenient Getters for snapshot values
  Esp32Telemetry get esp32 => esp32Notifier.value;
  BabyQcprTelemetry get babyQcpr => babyQcprNotifier.value;
  AiDiagnosticsData get aiDiagnostics => aiDiagnosticsNotifier.value;
  DeviceLocationData get location => locationNotifier.value;
  List<TelemetryLogItem> get logs => logsNotifier.value;

  // Mutation / Integration hooks
  void updateEsp32(Esp32Telemetry data) {
    esp32Notifier.value = data;
  }

  void updateBabyQcpr(BabyQcprTelemetry data) {
    babyQcprNotifier.value = data;
  }

  void updateAiDiagnostics(AiDiagnosticsData data) {
    aiDiagnosticsNotifier.value = data;
  }

  void updateLocation(DeviceLocationData data) {
    locationNotifier.value = data;
  }

  void addLog(TelemetryLogItem log) {
    logsNotifier.value = [log, ...logsNotifier.value];
  }

  /// Provides dynamic historical metric series and statistics for any requested metric
  MetricHistorySeries getMetricHistory(String title, {int timeframeIndex = 0}) {
    final cleanTitle = title.trim().toLowerCase();

    if (cleanTitle.contains('ventilation')) {
      final val = babyQcpr.ventilationVolume;
      return MetricHistorySeries(
        title: 'Ventilation Volume',
        unit: 'ML',
        currentValue: val.toStringAsFixed(0),
        targetRange: '80 - 110',
        meanValue: '94.2',
        efficiency: '96%',
        chartPoints: [45, 60, 75, 90, val, 88, 70, 95, 105, val, 85, 92, 100, 96, val],
        description: 'Measures tidal air volume delivered to the infant airway during ventilation cycles. Maintains optimal chest rise while avoiding barotrauma or gastric insufflation.',
      );
    } else if (cleanTitle.contains('rate') || cleanTitle.contains('cpm')) {
      final val = babyQcpr.compressionRate;
      return MetricHistorySeries(
        title: 'Compression Rate',
        unit: 'CPM',
        currentValue: val.toStringAsFixed(1),
        targetRange: '100 - 120',
        meanValue: '104.5',
        efficiency: '94%',
        chartPoints: [85, 92, 98, 102, 108, 112, 108, 105, val, 106, 110, val],
        description: 'Frequency of chest depressions measured in Cycles Per Minute. Regulated to meet AHA 2020 pediatric resuscitation guidelines (100-120 CPM).',
      );
    } else if (cleanTitle.contains('depth')) {
      final val = babyQcpr.compressionDepth;
      return MetricHistorySeries(
        title: 'Compression Depth',
        unit: 'CM',
        currentValue: val.toStringAsFixed(1),
        targetRange: '4.0 - 5.0',
        meanValue: '4.6',
        efficiency: '98%',
        chartPoints: [3.8, 4.1, 4.3, 4.6, 4.8, 4.7, 4.5, 4.6, 4.8, val, 4.7, val],
        description: 'Physical displacement depth of the infant sternum. Optimal compression depth ensures coronary perfusion pressure without skeletal trauma.',
      );
    } else if (cleanTitle.contains('instant') || cleanTitle.contains('instantaneous')) {
      final val = esp32.instantForce;
      return MetricHistorySeries(
        title: 'Instantaneous Force',
        unit: 'N',
        currentValue: val.toStringAsFixed(1),
        targetRange: '50 - 80',
        meanValue: '64.8',
        efficiency: '95%',
        chartPoints: [50, 56, 62, 68, 72, 65, 63, 67, 70, val, 66, val],
        description: 'Real-time normal force vector reported by the piezoelectric load cell on the robotic actuator plunger.',
      );
    } else if (cleanTitle.contains('peak')) {
      final val = esp32.peakForce;
      return MetricHistorySeries(
        title: 'Peak Force',
        unit: 'N',
        currentValue: val.toStringAsFixed(1),
        targetRange: '85 - 100',
        meanValue: '93.1',
        efficiency: '98%',
        chartPoints: [82, 88, 92, 94, 96, 93, 94.2, 95, val, 93, val],
        description: 'Maximum compressive peak force reached at the bottom of the stroke trajectory before the release phase.',
      );
    } else if (cleanTitle.contains('speed') || cleanTitle.contains('rpm')) {
      final val = esp32.motorSpeed;
      return MetricHistorySeries(
        title: 'Motor Speed',
        unit: 'RPM',
        currentValue: val.toStringAsFixed(0),
        targetRange: '100 - 120',
        meanValue: '108.0',
        efficiency: '97%',
        chartPoints: [96, 102, 106, 108, 108, 107, 109, 108, val, 108, val],
        description: 'Rotational velocity of the BLDC motor drive shaft, synced through the closed-loop PID servo controller.',
      );
    } else if (cleanTitle.contains('angle') || cleanTitle.contains('position')) {
      final val = esp32.positionAngle;
      return MetricHistorySeries(
        title: 'Position Angle',
        unit: '°',
        currentValue: val.toStringAsFixed(1),
        targetRange: '0 - 360',
        meanValue: '180.0',
        efficiency: '99%',
        chartPoints: [30, 60, 90, 120, 142.5, 180, 240, 300, 340, val],
        description: 'Absolute optical encoder angle tracking the cam mechanism position across each compression cycle.',
      );
    } else if (cleanTitle.contains('breaths')) {
      final val = babyQcpr.breaths;
      return MetricHistorySeries(
        title: 'Breaths',
        unit: 'BREATHS',
        currentValue: '$val',
        targetRange: '20 - 35',
        meanValue: '26',
        efficiency: '100%',
        chartPoints: [2, 6, 10, 14, 18, 22, 26, val.toDouble()],
        description: 'Cumulative count of synchronized ventilation cycles delivered during the current resuscitation protocol.',
      );
    } else if (cleanTitle.contains('release')) {
      final ok = babyQcpr.releaseOk;
      return MetricHistorySeries(
        title: 'Release Status',
        unit: '',
        currentValue: ok ? 'True' : 'False',
        targetRange: 'True',
        meanValue: ok ? '100%' : '78%',
        efficiency: ok ? '100%' : '78%',
        chartPoints: ok ? [1, 1, 1, 1, 1] : [1, 1, 0, 1, 0, 0],
        description: 'Verification of complete chest recoil between compressions, essential for venous return and heart chamber refill.',
      );
    } else {
      // General Fallback
      return MetricHistorySeries(
        title: title,
        unit: '',
        currentValue: '98',
        targetRange: '80 - 110',
        meanValue: '94.2',
        efficiency: '96%',
        chartPoints: [45, 60, 75, 90, 98, 88, 70, 95, 105, 98, 85, 92, 100, 96, 98],
        description: 'Detailed telemetry metric telemetry stream for $title.',
      );
    }
  }

  static final List<TelemetryLogItem> _initialLogs = [
    const TelemetryLogItem(
      name: 'W043_supervisor.json',
      time: '12:36:34',
      size: '1.1 KB',
      status: 'Derate',
      isDerate: true,
      category: 'ESP32',
      preview: '{\n  "event": "MOTOR_THERMAL_DERATE",\n  "temp_c": 54.2,\n  "action": "THROTTLE_RPM_TO_100",\n  "status": "SAFE"\n}',
      fullJson: '''{
  "event": "MOTOR_THERMAL_DERATE",
  "timestamp": "2026-09-25T12:36:34.120Z",
  "device_id": "ESP32-C3-SUPERVISOR-01",
  "subsystem": "ACTUATOR_DRIVE",
  "temperature": {
    "motor_coil_c": 54.2,
    "driver_mosfet_c": 49.8,
    "ambient_c": 28.1,
    "derate_threshold_c": 52.0
  },
  "action": {
    "throttle_rpm_to": 100,
    "pwm_duty_cycle_pct": 74.5,
    "recovery_strategy": "ACTIVE_COOLING_MONITOR",
    "status": "SAFE"
  },
  "diagnostics": {
    "operating_hours": 142.8,
    "fault_code": "WARN_TEMP_T1",
    "fail_safe_engaged": false
  }
}''',
    ),
    const TelemetryLogItem(
      name: 'W041_inference.json',
      time: '12:36:14',
      size: '2.3 KB',
      status: 'Normal',
      isDerate: false,
      category: 'AI',
      preview: '{\n  "event": "NOMINAL_CYCLE",\n  "depth_cm": 4.7,\n  "force_n": 94.2,\n  "compression_rate": 108,\n  "recoil": "COMPLETE"\n}',
      fullJson: '''{
  "event": "NOMINAL_CYCLE",
  "timestamp": "2026-09-25T12:36:14.882Z",
  "model": "OtoCPR-Edge-v2.1",
  "inference_id": "INF-20260925-041",
  "compression": {
    "depth_cm": 4.7,
    "depth_target_cm": [4.0, 5.0],
    "force_n": 94.2,
    "instant_force_n": 68.5,
    "compression_rate_cpm": 108,
    "target_rate_cpm": [100, 120],
    "recoil": "COMPLETE",
    "recoil_residual_n": 0.2
  },
  "quality_score": {
    "overall": 98.4,
    "depth_accuracy": 0.991,
    "rate_accuracy": 0.980,
    "recoil_accuracy": 0.982
  },
  "status": "NORMAL"
}''',
    ),
    const TelemetryLogItem(
      name: 'W040_supervisor.json',
      time: '12:35:54',
      size: '1.1 KB',
      status: 'Derate',
      isDerate: true,
      category: 'ESP32',
      preview: '{\n  "event": "OVERFORCE_WARNING",\n  "load_peak_n": 98.6,\n  "threshold_n": 95.0,\n  "recoil_adjustment": -2.0\n}',
      fullJson: '''{
  "event": "OVERFORCE_WARNING",
  "timestamp": "2026-09-25T12:35:54.015Z",
  "device_id": "ESP32-C3-SUPERVISOR-01",
  "subsystem": "LOAD_CELL_ARRAY",
  "force_telemetry": {
    "load_peak_n": 98.6,
    "threshold_n": 95.0,
    "differential_n": 3.6,
    "sample_rate_hz": 500
  },
  "mitigation": {
    "recoil_adjustment": -2.0,
    "stroke_limit_mm": 48.5,
    "auto_trim_applied": true
  },
  "safety_interlock": {
    "state": "ENGAGED_ADAPTIVE",
    "override_active": false
  }
}''',
    ),
    const TelemetryLogItem(
      name: 'W039_inference.json',
      time: '12:35:34',
      size: '2.3 KB',
      status: 'Normal',
      isDerate: false,
      category: 'Baby QCPR',
      preview: '{\n  "event": "VENTILATION_WINDOW",\n  "volume_ml": 98.0,\n  "duration_ms": 940,\n  "peak_flow": "OPTIMAL"\n}',
      fullJson: '''{
  "event": "VENTILATION_WINDOW",
  "timestamp": "2026-09-25T12:35:34.450Z",
  "model": "OtoCPR-Edge-v2.1",
  "ventilation": {
    "volume_ml": 98.0,
    "target_volume_ml": [90.0, 110.0],
    "duration_ms": 940,
    "peak_flow_lpm": 14.2,
    "flow_profile": "OPTIMAL",
    "airway_pressure_cmh2o": 18.4
  },
  "sync": {
    "compression_pause_ms": 1150,
    "synchronized": true
  },
  "status": "NORMAL"
}''',
    ),
    const TelemetryLogItem(
      name: 'W038_supervisor.json',
      time: '12:35:14',
      size: '1.1 KB',
      status: 'Derate',
      isDerate: true,
      category: 'ESP32',
      preview: '{\n  "event": "SHAFT_ENCODER_SYNC",\n  "jitter_us": 12,\n  "calibrated": true\n}',
      fullJson: '''{
  "event": "SHAFT_ENCODER_SYNC",
  "timestamp": "2026-09-25T12:35:14.200Z",
  "device_id": "ESP32-C3-SUPERVISOR-01",
  "subsystem": "OPTICAL_ENCODER",
  "encoder_metrics": {
    "jitter_us": 12,
    "quadrature_pulses_per_rev": 2048,
    "zero_index_offset_deg": 1.42,
    "calibrated": true
  },
  "motor_alignment": {
    "sync_lock": true,
    "phase_drift_deg": 0.04
  }
}''',
    ),
    const TelemetryLogItem(
      name: 'W037_inference.json',
      time: '12:34:54',
      size: '2.3 KB',
      status: 'Normal',
      isDerate: false,
      category: 'AI',
      preview: '{\n  "event": "CYCLE_START",\n  "protocol": "PEDIATRIC_AHA_2020",\n  "target_cpm": 110\n}',
      fullJson: '''{
  "event": "CYCLE_START",
  "protocol": "PEDIATRIC_AHA_2020",
  "timestamp": "2026-09-25T12:34:54.000Z",
  "session_id": "SESS-PEDS-2026-0037",
  "firmware": "OtoCPR-v2.1.4-Release",
  "parameters": {
    "target_cpm": 110,
    "target_cpm_min": 100,
    "target_cpm_max": 120,
    "target_depth_cm": 4.5,
    "recoil_threshold_n": 0.5,
    "duty_cycle_pct": 50,
    "ratio": "15:2",
    "patient_type": "PEDIATRIC_INFANT"
  },
  "preflight_status": {
    "actuator_calibrated": true,
    "load_cell_zeroed": true,
    "thermal_headroom_c": 31.8,
    "ble_rssi_dbm": -48,
    "battery_soc_pct": 94
  },
  "safety_limits": {
    "max_depth_cm": 5.0,
    "max_force_n": 100.0,
    "thermal_cutoff_c": 65.0
  }
}''',
    ),
  ];
}
