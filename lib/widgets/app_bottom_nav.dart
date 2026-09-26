import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0x33BB00FF), // #bb00ff with 20% opacity
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, 'Home'),
          _buildNavItem(1, Icons.show_chart_rounded, 'Telemetry'),
          _buildNavItem(2, Icons.auto_awesome_rounded, 'AI'),
          _buildNavItem(3, Icons.article_rounded, 'Logs'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    final color = isSelected ? Colors.white : Colors.white.withValues(alpha: 0.3);

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.sans(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
