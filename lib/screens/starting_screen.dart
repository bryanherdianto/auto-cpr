import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartingScreen extends StatelessWidget {
  final VoidCallback? onGetStarted;

  const StartingScreen({
    super.key,
    this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Baby CPR Manikin Image with soft vignette
          Positioned.fill(
            child: Opacity(
              opacity: 0.35,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const RadialGradient(
                    center: Alignment(0.0, 0.05),
                    radius: 0.85,
                    colors: [
                      Colors.white,
                      Colors.transparent,
                    ],
                    stops: [0.4, 1.0],
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/baby_image.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Spacer(),

                  // Center Lockup: Logo + OtoCPR title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_otocpr.png',
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'OtoCPR',
                        style: GoogleFonts.ibmPlexSans(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Bottom Action Button: "Get started"
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: onGetStarted ?? () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0x33BB00FF), // #bb00ff at 20%
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(29),
                            side: BorderSide(
                              color: const Color(0xFFBB00FF).withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          'Get started',
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
