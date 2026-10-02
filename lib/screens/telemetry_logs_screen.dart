import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class TelemetryLogsScreen extends StatefulWidget {
  const TelemetryLogsScreen({super.key});

  @override
  State<TelemetryLogsScreen> createState() => _TelemetryLogsScreenState();
}

class _TelemetryLogsScreenState extends State<TelemetryLogsScreen> {
  int _selectedCategory = 0; // 0: All, 1: ESP32, 2: Baby QCPR, 3: AI
  int? _selectedLogIndex;

  final List<Map<String, dynamic>> _logs = [
    {
      'name': 'W043_supervisor.json',
      'time': '12:36:34',
      'size': '1.1 KB',
      'status': 'Derate',
      'isDerate': true,
      'category': 'ESP32',
      'preview': '{\n  "event": "MOTOR_THERMAL_DERATE",\n  "temp_c": 54.2,\n  "action": "THROTTLE_RPM_TO_100",\n  "status": "SAFE"\n}',
      'fullJson': '''{
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
    },
    {
      'name': 'W041_inference.json',
      'time': '12:36:14',
      'size': '2.3 KB',
      'status': 'Normal',
      'isDerate': false,
      'category': 'AI',
      'preview': '{\n  "event": "NOMINAL_CYCLE",\n  "depth_cm": 4.7,\n  "force_n": 94.2,\n  "compression_rate": 108,\n  "recoil": "COMPLETE"\n}',
      'fullJson': '''{
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
    },
    {
      'name': 'W040_supervisor.json',
      'time': '12:35:54',
      'size': '1.1 KB',
      'status': 'Derate',
      'isDerate': true,
      'category': 'ESP32',
      'preview': '{\n  "event": "OVERFORCE_WARNING",\n  "load_peak_n": 98.6,\n  "threshold_n": 95.0,\n  "recoil_adjustment": -2.0\n}',
      'fullJson': '''{
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
    },
    {
      'name': 'W039_inference.json',
      'time': '12:35:34',
      'size': '2.3 KB',
      'status': 'Normal',
      'isDerate': false,
      'category': 'Baby QCPR',
      'preview': '{\n  "event": "VENTILATION_WINDOW",\n  "volume_ml": 98.0,\n  "duration_ms": 940,\n  "peak_flow": "OPTIMAL"\n}',
      'fullJson': '''{
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
    },
    {
      'name': 'W038_supervisor.json',
      'time': '12:35:14',
      'size': '1.1 KB',
      'status': 'Derate',
      'isDerate': true,
      'category': 'ESP32',
      'preview': '{\n  "event": "SHAFT_ENCODER_SYNC",\n  "jitter_us": 12,\n  "calibrated": true\n}',
      'fullJson': '''{
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
    },
    {
      'name': 'W037_inference.json',
      'time': '12:34:54',
      'size': '2.3 KB',
      'status': 'Normal',
      'isDerate': false,
      'category': 'AI',
      'preview': '{\n  "event": "CYCLE_START",\n  "protocol": "PEDIATRIC_AHA_2020",\n  "target_cpm": 110\n}',
      'fullJson': '''{
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
    },
  ];

  List<Map<String, dynamic>> get _filteredLogs {
    switch (_selectedCategory) {
      case 1:
        return _logs.where((l) => l['category'] == 'ESP32').toList();
      case 2:
        return _logs.where((l) => l['category'] == 'Baby QCPR').toList();
      case 3:
        return _logs.where((l) => l['category'] == 'AI').toList();
      case 0:
      default:
        return _logs;
    }
  }

  void _showLogDetailsSheet(BuildContext context, Map<String, dynamic> log) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (bottomSheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.38,
          minChildSize: 0.22,
          maxChildSize: 0.72,
          snap: true,
          snapSizes: const [0.38, 0.72],
          builder: (sheetContext, scrollController) {
            final fullJson = log['fullJson'] as String? ?? log['preview'] as String;
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFF101318),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                border: Border.all(color: AppColors.darkGray),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 20,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Top Drag Handle Bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.gray.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Header Row with filename, timestamp, and copy action
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.terminal_rounded, size: 16, color: AppColors.cyan),
                            const SizedBox(width: 8),
                            Text(
                              log['name'] as String,
                              style: AppTypography.mono(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              log['time'] as String,
                              style: AppTypography.mono(fontSize: 11, color: AppColors.gray),
                            ),
                            const SizedBox(width: 8),
                            _CopyLogButton(text: fullJson),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Clearer, fuller JSON viewer that can be dragged up & scrolled
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF22262E)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            padding: const EdgeInsets.all(12),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SelectableText(
                                fullJson,
                                style: AppTypography.mono(
                                  fontSize: 12,
                                  height: 1.5,
                                  color: const Color(0xFFC0CAD0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredLogs = _filteredLogs;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header & Sub-Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Machine Logs',
                        style: AppTypography.sans(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfacePurple,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          '${filteredLogs.length} Files',
                          style: AppTypography.mono(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sub-tabs: All | ESP32 | Baby QCPR | AI
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surfacePurple,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.purple.withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      children: [
                        _buildCategoryTab(0, 'All'),
                        _buildCategoryTab(1, 'ESP32'),
                        _buildCategoryTab(2, 'Baby QCPR'),
                        _buildCategoryTab(3, 'AI'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // High-density File Tree List (No drawer by default)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredLogs.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final log = filteredLogs[index];
                  final isSelected = _selectedLogIndex == index;
                  final isDerate = log['isDerate'] as bool;
                  final statusColor = isDerate ? AppColors.red : AppColors.cyan;
                  final statusBg = isDerate ? AppColors.surfaceRed : AppColors.surfaceCard;

                  return InkWell(
                    onTap: () {
                      setState(() => _selectedLogIndex = index);
                      _showLogDetailsSheet(context, log);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF181C22) : const Color(0xFF0D0D0D),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? statusColor.withValues(alpha: 0.6) : AppColors.darkGray,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              isDerate ? Icons.warning_amber_rounded : Icons.code_rounded,
                              size: 16,
                              color: statusColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  log['name'] as String,
                                  style: AppTypography.mono(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${log['time']} · ${log['size']}',
                                  style: AppTypography.sans(fontSize: 11, color: AppColors.gray),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                            ),
                            child: Text(
                              log['status'] as String,
                              style: AppTypography.sans(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(int index, String title) {
    final isSelected = _selectedCategory == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _selectedCategory = index;
          _selectedLogIndex = null;
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.purple.withValues(alpha: 0.4) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.sans(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : AppColors.gray,
            ),
          ),
        ),
      ),
    );
  }
}

class _CopyLogButton extends StatefulWidget {
  final String text;
  const _CopyLogButton({required this.text});

  @override
  State<_CopyLogButton> createState() => _CopyLogButtonState();
}

class _CopyLogButtonState extends State<_CopyLogButton> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: widget.text));
        setState(() => _copied = true);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _copied = false);
        });
      },
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          _copied ? Icons.check_rounded : Icons.copy_rounded,
          size: 16,
          color: _copied ? AppColors.green : AppColors.cyan,
        ),
      ),
    );
  }
}
