import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TelemetryDetailsScreen extends StatefulWidget {
  final String title;
  final String currentValue;
  final String unit;

  const TelemetryDetailsScreen({
    super.key,
    this.title = 'Ventilation Volume',
    this.currentValue = '98',
    this.unit = 'ML',
  });

  @override
  State<TelemetryDetailsScreen> createState() => _TelemetryDetailsScreenState();
}

class _TelemetryDetailsScreenState extends State<TelemetryDetailsScreen> {
  int _selectedTimeframe = 0;
  final List<String> _timeframes = ['1m', '5m', '15m', 'All'];

  final List<double> _chartData = [
    45, 60, 75, 90, 98, 88, 70, 95, 105, 98, 85, 92, 100, 96, 98
  ];

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
              // Top Bar: Back Button + Title
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1E1E),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: AppTypography.sans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.cyan.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      'Live',
                      style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.cyan),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Timeframe Selector Tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfacePurple,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.purple.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: List.generate(_timeframes.length, (index) {
                    final isSelected = _selectedTimeframe == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTimeframe = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.purple.withValues(alpha: 0.4) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _timeframes[index],
                            textAlign: TextAlign.center,
                            style: AppTypography.sans(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected ? Colors.white : AppColors.gray,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              // Hero Metric Display
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    widget.currentValue,
                    style: AppTypography.mono(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.unit,
                    style: AppTypography.sans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Section: Data Distribution Chart
              Text(
                'Data Distribution',
                style: AppTypography.sans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 220,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1216),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cyan.withValues(alpha: 0.25)),
                ),
                child: CustomPaint(
                  size: Size.infinite,
                  painter: _TelemetryChartPainter(data: _chartData),
                ),
              ),

              const SizedBox(height: 24),

              // Section: Summary Cards
              Text(
                'Summary',
                style: AppTypography.sans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cyan.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('Target Range', '80 - 110', widget.unit),
                    Container(width: 1, height: 36, color: AppColors.gray.withValues(alpha: 0.3)),
                    _buildStat('Mean Value', '94.2', widget.unit),
                    Container(width: 1, height: 36, color: AppColors.gray.withValues(alpha: 0.3)),
                    _buildStat('Efficiency', '96%', ''),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Section: About Metric
              Text(
                'About ${widget.title}',
                style: AppTypography.sans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfacePurple,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
                ),
                child: Text(
                  'Continuous telemetry tracks pulmonary displacement and tidal compliance. High precision flow monitoring guarantees pediatric lung over-inflation safety and verifies resuscitation volume thresholds in real-time.',
                  style: AppTypography.sans(
                    fontSize: 13,
                    height: 1.6,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.sans(fontSize: 11, color: AppColors.gray),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: AppTypography.mono(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (unit.isNotEmpty) ...[
              const SizedBox(width: 2),
              Text(
                unit,
                style: AppTypography.sans(fontSize: 10, color: AppColors.gray),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _TelemetryChartPainter extends CustomPainter {
  final List<double> data;
  _TelemetryChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paintBar = Paint()
      ..color = AppColors.cyan.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    final paintLine = Paint()
      ..color = AppColors.purple
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final barWidth = size.width / (data.length * 1.5);
    final maxVal = 120.0;

    final path = Path();
    for (int i = 0; i < data.length; i++) {
      final x = i * (size.width / (data.length - 1));
      final barHeight = (data[i] / maxVal) * size.height;
      final y = size.height - barHeight;

      // Draw bar
      final barRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x - barWidth / 2, y, barWidth, barHeight),
        const Radius.circular(4),
      );
      canvas.drawRRect(barRect, paintBar);

      // Path for overlay line
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
