import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/features/authentication/views/email_signup_screen.dart';
import 'package:precious_people/features/authentication/views/widgets/auth_button.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/constants/sizes.dart';

class SignUpScreen extends ConsumerWidget {
  static String routeUrl = "/signUp";
  static String routeName = "signUp";
  const SignUpScreen({super.key});

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
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
                  "회원가입",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v10,
              Center(
                child: Text(
                  "소사와 함께 당신의 소중한 인맥을 유지하세요.",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v72,
              AuthButton(
                  text: "Email 가입",
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
