import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TelemetryHomeScreen extends StatelessWidget {
  final VoidCallback? onNavigateToTelemetry;
  final VoidCallback? onNavigateToLogs;

  const TelemetryHomeScreen({
    super.key,
    this.onNavigateToTelemetry,
    this.onNavigateToLogs,
  });

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
              // Header: Brand & App Title
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo_otocpr.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'OtoCPR',
                    style: AppTypography.sans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfacePurple,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.purple.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
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
                          'BLE Active',
                          style: AppTypography.sans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // System Status Header Bar (Device Status & Anomaly Status)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfacePurple,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.purple.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    // Device Status
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Device Status',
                            style: AppTypography.sans(
                              fontSize: 12,
                              color: AppColors.gray,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceCard,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.cyan.withValues(alpha: 0.5),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check_circle_rounded, size: 14, color: AppColors.cyan),
                                const SizedBox(width: 6),
                                Text(
                                  'Connected',
                                  style: AppTypography.sans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 40,
                      color: AppColors.purple.withValues(alpha: 0.3),
                    ),

                    // Anomaly Status
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Anomaly Status',
                              style: AppTypography.sans(
                                fontSize: 12,
                                color: AppColors.gray,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceRed,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.red.withValues(alpha: 0.5),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.warning_amber_rounded, size: 14, color: AppColors.red),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Flagged',
                                    style: AppTypography.sans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Section: Connect your Devices
              Text(
                'Connect your Devices',
                style: AppTypography.sans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDeviceCard(
                      title: 'ESP32',
                      subtitle: 'Carrier Hub',
                      icon: Icons.memory_rounded,
                      isConnected: true,
                      onTap: onNavigateToTelemetry,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDeviceCard(
                      title: 'QCPR',
                      subtitle: 'Resusci Baby',
                      icon: Icons.child_care_rounded,
                      isConnected: true,
                      onTap: onNavigateToTelemetry,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Section: Device Location
              Text(
                'Device Location',
                style: AppTypography.sans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.purple.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/map_location.png',
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF141A22),
                            child: const Center(
                              child: Icon(Icons.map_rounded, size: 48, color: AppColors.cyan),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        left: 12,
                        bottom: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.cyan.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_rounded, size: 14, color: AppColors.cyan),
                              const SizedBox(width: 4),
                              Text(
                                'Lat: -6.2088° · Long: 106.8456°',
                                style: AppTypography.mono(
                                  fontSize: 11,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Section: Machine Logs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Machine Logs',
                    style: AppTypography.sans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (onNavigateToLogs != null)
                    TextButton(
                      onPressed: onNavigateToLogs,
                      child: Text(
                        'View all',
                        style: AppTypography.sans(
                          fontSize: 13,
                          color: AppColors.cyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              _buildLogsCard(
                filename: 'W043_supervisor.json',
                timestamp: '12:36:34',
                size: '1.1 KB',
                status: 'Derate',
                isDerate: true,
              ),
              const SizedBox(height: 8),
              _buildLogsCard(
                filename: 'W041_inference.json',
                timestamp: '12:36:14',
                size: '2.3 KB',
                status: 'Normal',
                isDerate: false,
              ),
              const SizedBox(height: 8),
              _buildLogsCard(
                filename: 'W040_supervisor.json',
                timestamp: '12:35:54',
                size: '1.1 KB',
                status: 'Derate',
                isDerate: true,
              ),
              const SizedBox(height: 8),
              _buildLogsCard(
                filename: 'W039_inference.json',
                timestamp: '12:35:34',
                size: '2.3 KB',
                status: 'Normal',
                isDerate: false,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isConnected,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfacePurple,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.purple.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: AppColors.purple, size: 28),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isConnected ? AppColors.green : AppColors.gray,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTypography.sans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTypography.sans(
                fontSize: 12,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogsCard({
    required String filename,
    required String timestamp,
    required String size,
    required String status,
    required bool isDerate,
  }) {
    final statusColor = isDerate ? AppColors.red : AppColors.cyan;
    final statusBg = isDerate ? AppColors.surfaceRed : AppColors.surfaceCard;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.darkGray,
          width: 1,
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
              isDerate ? Icons.error_outline_rounded : Icons.description_outlined,
              size: 18,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filename,
                  style: AppTypography.mono(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$timestamp · $size',
                  style: AppTypography.sans(
                    fontSize: 11,
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: statusColor.withValues(alpha: 0.4),
              ),
            ),
            child: Text(
              status,
              style: AppTypography.sans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
