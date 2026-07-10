import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:woho/services/authentication_service.dart';
import 'package:woho/view/authentication/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      AuthenticationService().userexist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff1F1147), Color(0xff432371), Color(0xffFA4A8D)],
          ),
        ),
        child: Stack(
          children: [
            /// Expanding Circle 1
            Center(
              child:
                  Container(
                        width: 320,
                        height: 320,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(.04),
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .scale(
                        begin: const Offset(.5, .5),
                        end: const Offset(1.2, 1.2),
                        duration: 3000.ms,
                      )
                      .fadeOut(),
            ),

            /// Expanding Circle 2
            Center(
              child:
                  Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(.06),
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .scale(
                        begin: const Offset(.5, .5),
                        end: const Offset(1.3, 1.3),
                        duration: 2500.ms,
                      )
                      .fadeOut(),
            ),

            /// Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Logo
                  Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(.4),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(35),
                            ),
                            child: Image.asset("asset/woho_logo.png"),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .scale(curve: Curves.elasticOut, duration: 900.ms)
                      .rotate(begin: -.08, end: 0),

                  const SizedBox(height: 40),

                  const Text(
                    "WOHO",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 42,
                      letterSpacing: 8,
                    ),
                  ).animate(delay: 700.ms).slideY(begin: 1).fadeIn().scale(),

                  const SizedBox(height: 15),

                  const Text(
                    "Share Your World",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ).animate(delay: 1300.ms).fadeIn().slideY(begin: .5),

                  const SizedBox(height: 60),

                  const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ).animate(delay: 1800.ms).fadeIn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
