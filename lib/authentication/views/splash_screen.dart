import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/authentication/views/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeUrl = "/slpash";
  static String routeName = "slpash";
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
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Precious People",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            Text(
              "Wait Screen",
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
