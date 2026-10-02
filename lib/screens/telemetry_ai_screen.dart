import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../services/telemetry_repository.dart';

class TelemetryAiScreen extends StatefulWidget {
  const TelemetryAiScreen({super.key});

  @override
  State<TelemetryAiScreen> createState() => _TelemetryAiScreenState();
}

class _TelemetryAiScreenState extends State<TelemetryAiScreen> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: TelemetryRepository.instance.aiDiagnosticsNotifier,
          builder: (context, ai, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'AI Diagnostics',
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome_rounded, size: 14, color: AppColors.purple),
                            const SizedBox(width: 6),
                            Text(
                              'Edge Inference',
                              style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Primary Hero Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0x33BB00FF),
                          Color(0x223BA9DA),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.purple.withValues(alpha: 0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.green.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${ai.confidence.toStringAsFixed(1)}% CONFIDENCE',
                            style: AppTypography.mono(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.green),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ai.classification,
                          style: AppTypography.sans(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ai.guidelineSubtitle,
                          style: AppTypography.sans(fontSize: 12, color: AppColors.gray),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Diagnostic Insight
                  Text(
                    'Diagnostic Insight',
                    style: AppTypography.sans(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfacePurple,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      ai.diagnosticInsight,
                      style: AppTypography.sans(
                        fontSize: 13,
                        height: 1.6,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Data Evidence Grid
                  Text(
                    'Data Evidence',
                    style: AppTypography.sans(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildEvidenceCard(
                          'Tidal Volume',
                          '${ai.tidalVolume.toStringAsFixed(0)} ML',
                          'Nominal',
                          AppColors.cyan,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildEvidenceCard(
                          'Stroke Force',
                          '${ai.strokeForce.toStringAsFixed(1)} N',
                          'Target',
                          AppColors.cyan,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildEvidenceCard(
                          'Recoil Residual',
                          '${ai.recoilResidual.toStringAsFixed(1)} N',
                          'Clear',
                          AppColors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildEvidenceCard(
                          'Fatigue Drift',
                          '${ai.fatigueDrift.toStringAsFixed(1)}%',
                          'Low',
                          AppColors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Window History / Trend Bar
                  Text(
                    'Window History',
                    style: AppTypography.sans(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F1216),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cyan.withValues(alpha: 0.25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Session Health Index', style: AppTypography.sans(fontSize: 13, color: AppColors.gray)),
                            Text(
                              '${ai.sessionHealthIndex.toStringAsFixed(1)}%',
                              style: AppTypography.mono(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Row(
                            children: [
                              Expanded(flex: 6, child: Container(height: 10, color: AppColors.green)),
                              const SizedBox(width: 2),
                              Expanded(flex: 2, child: Container(height: 10, color: AppColors.cyan)),
                              const SizedBox(width: 2),
                              Expanded(flex: 8, child: Container(height: 10, color: AppColors.green)),
                              const SizedBox(width: 2),
                              Expanded(flex: 1, child: Container(height: 10, color: AppColors.purple)),
                              const SizedBox(width: 2),
                              Expanded(flex: 5, child: Container(height: 10, color: AppColors.green)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('-10m', style: AppTypography.mono(fontSize: 10, color: AppColors.gray)),
                            Text('Now', style: AppTypography.mono(fontSize: 10, color: AppColors.gray)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Raw JSON Data
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Raw JSON Data',
                        style: AppTypography.sans(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: ai.rawJson));
                          setState(() => _copied = true);
                          Future.delayed(const Duration(seconds: 2), () {
                            if (mounted) setState(() => _copied = false);
                          });
                        },
                        icon: Icon(_copied ? Icons.check_rounded : Icons.copy_rounded, size: 14, color: AppColors.cyan),
                        label: Text(
                          _copied ? 'Copied' : 'Copy',
                          style: AppTypography.sans(fontSize: 12, color: AppColors.cyan, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A0C0E),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.darkGray),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        ai.rawJson,
                        style: AppTypography.mono(fontSize: 11, height: 1.5, color: const Color(0xFFC0CAD0)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEvidenceCard(String label, String value, String status, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTypography.sans(fontSize: 12, color: AppColors.gray)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: AppTypography.sans(fontSize: 10, fontWeight: FontWeight.w600, color: accentColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTypography.mono(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
