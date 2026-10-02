import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/app_theme.dart';
import '../services/telemetry_repository.dart';

class DeviceLocationMap extends StatefulWidget {
  final LatLng? initialPosition;
  final double height;
  final ValueChanged<bool>? onInteractingChange;

  const DeviceLocationMap({
    super.key,
    this.initialPosition,
    this.height = 280,
    this.onInteractingChange,
  });

  @override
  State<DeviceLocationMap> createState() => _DeviceLocationMapState();
}

class _DeviceLocationMapState extends State<DeviceLocationMap> {
  late final MapController _mapController;
  double _currentZoom = 15.0;

  LatLng get _currentPos {
    if (widget.initialPosition != null) return widget.initialPosition!;
    final loc = TelemetryRepository.instance.location;
    return LatLng(loc.latitude, loc.longitude);
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(3.0, 18.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(3.0, 18.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _recenter() {
    setState(() {
      _currentZoom = 15.0;
      _mapController.move(_currentPos, _currentZoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TelemetryRepository.instance.locationNotifier,
      builder: (context, location, child) {
        final pos = _currentPos;

        return Listener(
          onPointerDown: (_) => widget.onInteractingChange?.call(true),
          onPointerUp: (_) => widget.onInteractingChange?.call(false),
          onPointerCancel: (_) => widget.onInteractingChange?.call(false),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: widget.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF141A22),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.purple.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: pos,
                      initialZoom: _currentZoom,
                      minZoom: 3.0,
                      maxZoom: 18.0,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.all,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.otocpr.auto_cpr',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: pos,
                            width: 50,
                            height: 50,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.cyan.withValues(alpha: 0.25),
                                  ),
                                ),
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.cyan,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.cyan.withValues(alpha: 0.6),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.near_me_rounded,
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Coordinates Badge (Bottom-Left)
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.cyan.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on_rounded, size: 14, color: AppColors.cyan),
                          const SizedBox(width: 4),
                          Text(
                            'Lat: ${pos.latitude.toStringAsFixed(4)}° · Long: ${pos.longitude.toStringAsFixed(4)}°',
                            style: AppTypography.mono(
                              fontSize: 11,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

              // Floating Map Controls (Top-Right: Zoom in, Zoom out, Recenter)
              Positioned(
                top: 12,
                right: 12,
                child: Column(
                  children: [
                    _buildControlButton(
                      icon: Icons.add_rounded,
                      onPressed: _zoomIn,
                      tooltip: 'Zoom in',
                    ),
                    const SizedBox(height: 6),
                    _buildControlButton(
                      icon: Icons.remove_rounded,
                      onPressed: _zoomOut,
                      tooltip: 'Zoom out',
                    ),
                    const SizedBox(height: 6),
                    _buildControlButton(
                      icon: Icons.my_location_rounded,
                      onPressed: _recenter,
                      tooltip: 'Recenter',
                      iconColor: AppColors.cyan,
                    ),
                  ],
                ),
              ),

              // OpenStreetMap attribution badge (Bottom-Right, subtle)
              Positioned(
                right: 8,
                bottom: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '© OpenStreetMap',
                    style: AppTypography.sans(
                      fontSize: 9,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
}

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
    Color iconColor = Colors.white,
  }) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFF181C22).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.darkGray),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 6,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 18, color: iconColor),
        onPressed: onPressed,
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        splashRadius: 18,
      ),
    );
  }
}
