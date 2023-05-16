import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/gaps.dart';

class SaveNotificationScreen extends StatefulWidget {
  static String routeUrl = "/saveNotification";
  static String routeName = "saveNotification";
  const SaveNotificationScreen({super.key});

  @override
  State<SaveNotificationScreen> createState() => _SaveNotificationScreenState();
}

class _SaveNotificationScreenState extends State<SaveNotificationScreen> {
  void _loadingComplete() {
    context.go('/home');
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.circleCheck,
              size: 80,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Gaps.v5,
            const Text(
              "추억이 기록되었어요!",
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
