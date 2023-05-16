import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/authentication/views/introScreen.dart';

class SplashScreen extends StatefulWidget {
  static String routeUrl = "/splash";
  static String routeName = "splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _loadingComplete() {
    context.goNamed(IntroScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      _loadingComplete();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAAE2D1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "소중한 사람들",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            Text(
              "당신의 소중한 인연을 이어가세요.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
