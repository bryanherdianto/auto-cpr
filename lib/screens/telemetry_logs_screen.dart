import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TelemetryLogsScreen extends StatefulWidget {
  const TelemetryLogsScreen({super.key});

  @override
  State<TelemetryLogsScreen> createState() => _TelemetryLogsScreenState();
}

class _TelemetryLogsScreenState extends State<TelemetryLogsScreen> {
  int _selectedCategory = 0; // 0: ESP32, 1: Baby QCPR, 2: AI
  int _selectedLogIndex = 0;

  final List<Map<String, dynamic>> _logs = [
    {
      'name': 'W043_supervisor.json',
      'time': '12:36:34',
      'size': '1.1 KB',
      'status': 'Derate',
      'isDerate': true,
      'preview': '{\n  "event": "MOTOR_THERMAL_DERATE",\n  "temp_c": 54.2,\n  "action": "THROTTLE_RPM_TO_100",\n  "status": "SAFE"\n}'
    },
    {
      'name': 'W041_inference.json',
      'time': '12:36:14',
      'size': '2.3 KB',
      'status': 'Normal',
      'isDerate': false,
      'preview': '{\n  "event": "NOMINAL_CYCLE",\n  "depth_cm": 4.7,\n  "force_n": 94.2,\n  "compression_rate": 108,\n  "recoil": "COMPLETE"\n}'
    },
    {
      'name': 'W040_supervisor.json',
      'time': '12:35:54',
      'size': '1.1 KB',
      'status': 'Derate',
      'isDerate': true,
      'preview': '{\n  "event": "OVERFORCE_WARNING",\n  "load_peak_n": 98.6,\n  "threshold_n": 95.0,\n  "recoil_adjustment": -2.0\n}'
    },
    {
      'name': 'W039_inference.json',
      'time': '12:35:34',
      'size': '2.3 KB',
      'status': 'Normal',
      'isDerate': false,
      'preview': '{\n  "event": "VENTILATION_WINDOW",\n  "volume_ml": 98.0,\n  "duration_ms": 940,\n  "peak_flow": "OPTIMAL"\n}'
    },
    {
      'name': 'W038_supervisor.json',
      'time': '12:35:14',
      'size': '1.1 KB',
      'status': 'Derate',
      'isDerate': true,
      'preview': '{\n  "event": "SHAFT_ENCODER_SYNC",\n  "jitter_us": 12,\n  "calibrated": true\n}'
    },
    {
      'name': 'W037_inference.json',
      'time': '12:34:54',
      'size': '2.3 KB',
      'status': 'Normal',
      'isDerate': false,
      'preview': '{\n  "event": "CYCLE_START",\n  "protocol": "PEDIATRIC_AHA_2020",\n  "target_cpm": 110\n}'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedLog = _logs[_selectedLogIndex];

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
                          '${_logs.length} Files',
                          style: AppTypography.mono(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 3-way Sub-tabs: ESP32 | Baby QCPR | AI
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surfacePurple,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.purple.withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      children: [
                        _buildCategoryTab(0, 'ESP32'),
                        _buildCategoryTab(1, 'Baby QCPR'),
                        _buildCategoryTab(2, 'AI'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // High-density File Tree List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _logs.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  final isSelected = _selectedLogIndex == index;
                  final isDerate = log['isDerate'] as bool;
                  final statusColor = isDerate ? AppColors.red : AppColors.cyan;
                  final statusBg = isDerate ? AppColors.surfaceRed : AppColors.surfaceCard;

                  return InkWell(
                    onTap: () => setState(() => _selectedLogIndex = index),
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

            // Inspector / Code Preview Bottom Drawer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF101318),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                border: Border.all(color: AppColors.darkGray),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.gray.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.terminal_rounded, size: 16, color: AppColors.cyan),
                          const SizedBox(width: 8),
                          Text(
                            selectedLog['name'] as String,
                            style: AppTypography.mono(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        selectedLog['time'] as String,
                        style: AppTypography.mono(fontSize: 11, color: AppColors.gray),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF22262E)),
                    ),
                    child: Text(
                      selectedLog['preview'] as String,
                      style: AppTypography.mono(
                        fontSize: 11,
                        height: 1.4,
                        color: const Color(0xFFB0BAC0),
                      ),
                    ),
                  ),
                ],
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
        onTap: () => setState(() => _selectedCategory = index),
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
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : AppColors.gray,
            ),
          ),
        ),
      ),
    );
  }
}
