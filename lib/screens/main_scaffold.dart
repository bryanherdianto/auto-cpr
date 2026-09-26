import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import 'telemetry_home_screen.dart';
import 'telemetry_screen.dart';
import 'telemetry_ai_screen.dart';
import 'telemetry_logs_screen.dart';

class MainScaffold extends StatefulWidget {
  final int initialIndex;

  const MainScaffold({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      TelemetryHomeScreen(
        onNavigateToTelemetry: () => _onTabSelected(1),
        onNavigateToLogs: () => _onTabSelected(3),
      ),
      const TelemetryScreen(),
      const TelemetryAiScreen(),
      const TelemetryLogsScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
