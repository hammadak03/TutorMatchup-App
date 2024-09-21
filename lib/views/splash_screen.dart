import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushNamed(context, Routes.login),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            child: const SizedBox(
              height: 200,
              width: 200,
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/tutormatchup_logo.png'),
                ),
              ),
            ),
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: _controller.value * 1.0 * math.pi,
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
