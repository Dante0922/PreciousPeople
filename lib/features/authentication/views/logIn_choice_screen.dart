import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/features/authentication/views/widgets/auth_button.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import 'email_login_screen.dart';

class LogInScreen extends ConsumerWidget {
  static String routeUrl = "/logIn";
  static String routeName = "logIn";
  const LogInScreen({super.key});

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailLoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size52,
            vertical: Sizes.size32,
          ),
          child: Column(
            children: [
              Gaps.v96,
              Center(
                child: Text(
                  "로그인",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v10,
              Center(
                child: Text(
                  "당신의 소중한 관계을 유지하세요.",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v72,
              AuthButton(
                  text: "Email 로그인",
                  icon: const FaIcon(
                    FontAwesomeIcons.user,
                  ),
                  onTapFunction: _onEmailTap),
              Gaps.v10,
              FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/kakao_login_large_wide.png"),
                    ),
                  ),
                ),
              ),
              Gaps.v10,
            ],
          ),
        ),
      ),
    );
  }
}
