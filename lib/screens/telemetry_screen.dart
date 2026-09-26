import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'telemetry_details_screen.dart';

class TelemetryScreen extends StatefulWidget {
  const TelemetryScreen({super.key});

  @override
  State<TelemetryScreen> createState() => _TelemetryScreenState();
}

class _TelemetryScreenState extends State<TelemetryScreen> {
  int _selectedSubTab = 0; // 0: ESP32, 1: Resusci Baby QCPR

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Sub-Tabs: ESP32 vs Resusci Baby QCPR
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfacePurple,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.purple.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedSubTab = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedSubTab == 0
                                ? AppColors.purple.withValues(alpha: 0.4)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'ESP32',
                            textAlign: TextAlign.center,
                            style: AppTypography.sans(
                              fontSize: 14,
                              fontWeight: _selectedSubTab == 0 ? FontWeight.bold : FontWeight.normal,
                              color: _selectedSubTab == 0 ? Colors.white : AppColors.gray,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedSubTab = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedSubTab == 1
                                ? AppColors.purple.withValues(alpha: 0.4)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Resusci Baby QCPR',
                            textAlign: TextAlign.center,
                            style: AppTypography.sans(
                              fontSize: 14,
                              fontWeight: _selectedSubTab == 1 ? FontWeight.bold : FontWeight.normal,
                              color: _selectedSubTab == 1 ? Colors.white : AppColors.gray,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Real-time Data Section Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'real-time data',
                    style: AppTypography.sans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Streaming',
                        style: AppTypography.sans(
                          fontSize: 12,
                          color: AppColors.cyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // 6-Card Telemetry Grid
              if (_selectedSubTab == 0) _buildEsp32Grid() else _buildBabyQcprGrid(),

              const SizedBox(height: 24),

              // Summary Section
              Text(
                'Summary',
                style: AppTypography.sans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (_selectedSubTab == 0) _buildEsp32Summary() else _buildBabyQcprSummary(),

              const SizedBox(height: 24),

              // About Section
              Text(
                _selectedSubTab == 0 ? 'About ESP32' : 'About Resusci Baby QCPR',
                style: AppTypography.sans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfacePurple,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.purple.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  _selectedSubTab == 0
                      ? 'Powered by an ultra-compact ESP32-C3 micro on a custom carrier PCB, this controller acts as the central telemetry hub. It handles real-time motor encoder feedback (shaft angle, direction, and RPM) alongside load cell force readings to verify compression dynamics and chest recoil, streaming synchronized hardware metrics directly over BLE.'
                      : 'Resusci Baby QCPR provides comprehensive sensor telemetry regarding pediatric airway management, chest compression recoil, depth precision, and ventilation rate. Metrics update wirelessly to validate resuscitation protocols.',
                  style: AppTypography.sans(
                    fontSize: 13,
                    height: 1.6,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEsp32Grid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Instant force',
                value: '68.5',
                unit: 'N',
                icon: Icons.trending_up_rounded,
                onTap: () => _openDetails('Instantaneous Force', '68.5', 'N'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Peak force',
                value: '94.2',
                unit: 'N',
                icon: Icons.compress_rounded,
                onTap: () => _openDetails('Peak Force', '94.2', 'N'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Position Angle',
                value: '142.5',
                unit: '°',
                icon: Icons.rotate_right_rounded,
                onTap: () => _openDetails('Position Angle', '142.5', '°'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Motor Speed',
                value: '108',
                unit: 'RPM',
                icon: Icons.speed_rounded,
                onTap: () => _openDetails('Motor Speed', '108', 'RPM'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Direction',
                value: 'CW',
                unit: '',
                icon: Icons.sync_rounded,
                onTap: () => _openDetails('Direction', 'CW', ''),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Compression Count',
                value: '842',
                unit: 'CYC',
                icon: Icons.repeat_rounded,
                onTap: () => _openDetails('Compression Count', '842', 'CYC'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBabyQcprGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'ventilation volume',
                value: '98',
                unit: 'ML',
                icon: Icons.air_rounded,
                onTap: () => _openDetails('Ventilation Volume', '98', 'ML'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Compression rate',
                value: '94.2',
                unit: 'CPM',
                icon: Icons.favorite_rounded,
                onTap: () => _openDetails('Compression Rate', '94.2', 'CPM'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Compression Depth',
                value: '4.7',
                unit: 'CM',
                icon: Icons.straighten_rounded,
                onTap: () => _openDetails('Compression Depth', '4.7', 'CM'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Compression Count',
                value: '108',
                unit: 'CYC',
                icon: Icons.repeat_rounded,
                onTap: () => _openDetails('Compression Count', '108', 'CYC'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Release OK',
                value: 'False',
                unit: '',
                isAlert: true,
                icon: Icons.cancel_outlined,
                onTap: () => _openDetails('Release Status', 'False', ''),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Breaths',
                value: '28',
                unit: 'BREATHS',
                icon: Icons.air_rounded,
                onTap: () => _openDetails('Breaths', '28', 'BREATHS'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    bool isAlert = false,
    VoidCallback? onTap,
  }) {
    final bgColor = isAlert ? AppColors.surfaceRed : AppColors.surfaceCard;
    final accentColor = isAlert ? AppColors.red : AppColors.cyan;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.35),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: AppTypography.mono(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (unit.isNotEmpty) ...[
                      const SizedBox(width: 4),
                      Text(
                        unit,
                        style: AppTypography.sans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ],
                ),
                Icon(icon, size: 18, color: accentColor),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppTypography.sans(
                fontSize: 13,
                color: AppColors.white.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEsp32Summary() {
    return Column(
      children: [
        _buildSummaryRow('mean peak force', '95.4', 'N'),
        const SizedBox(height: 8),
        _buildSummaryRow('median speed', '109', 'RPM'),
        const SizedBox(height: 8),
        _buildSummaryRow('mean recoil force', '0.2', 'N'),
      ],
    );
  }

  Widget _buildBabyQcprSummary() {
    return Column(
      children: [
        _buildSummaryRow('mean ventilation volume', '96.8', 'ML'),
        const SizedBox(height: 8),
        _buildSummaryRow('median depth', '4.6', 'CM'),
        const SizedBox(height: 8),
        _buildSummaryRow('mean compression rate', '98.1', 'CPM'),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.cyan.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.sans(
              fontSize: 14,
              color: AppColors.white,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTypography.mono(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: AppTypography.sans(
                  fontSize: 12,
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openDetails(String title, String value, String unit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelemetryDetailsScreen(
          title: title,
          currentValue: value,
          unit: unit,
        ),
      ),
    );
  }
}
