import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/features/authentication/view_models/social_auth_view_model.dart';
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
  void _onGoogleTap(BuildContext context , WidgetRef ref){
    ref.read(socialAuthProvider.notifier).googleSignIn(context);
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
                  text: "Email 가입",
                  icon: const FaIcon(
                    FontAwesomeIcons.user,
                  ),
                  onTapFunction: _onEmailTap),
              Gaps.v10,
              AuthButton(
                  text: "Google 가입",
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                  ),
                  onTapFunction: (_)=>_onGoogleTap(context, ref),),

              Gaps.v10,
            ],
          ),
        ),
      ),
    );
  }
}
