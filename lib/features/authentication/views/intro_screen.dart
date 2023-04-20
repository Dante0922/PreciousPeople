import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/authentication/views/log_in_screen.dart';
import 'package:precious_people/features/authentication/views/sign_up_screen.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatelessWidget {
  static String routeUrl = "/intro";
  static String routeName = "intro";
  const IntroScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    context.pushNamed(SignUpScreen.routeName);
  }

  void _onLogInTap(BuildContext context) {
    context.pushNamed(LogInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("환영합니다."),
      ),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: PageView(
                controller: pageController,
                children: const [
                  Center(
                    child: Text(
                      "소개 1",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "소개 2",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "소개 3",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              child: Padding(
            padding: const EdgeInsets.only(
              top: Sizes.size20,
              bottom: Sizes.size40,
            ),
            child: SmoothPageIndicator(
                controller: pageController, // PageController
                count: 3,
                effect: WormEffect(
                  dotColor: Theme.of(context).splashColor,
                  activeDotColor: Theme.of(context).primaryColor,
                ), // your preferred effect

                onDotClicked: (index) {}),
          ))
        ],
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: [
              CupertinoButton(
                color: Theme.of(context).primaryColor,
                onPressed: () => _onLogInTap(context),
                child: const Text("로그인"),
              ),
              Gaps.h10,
              CupertinoButton(
                color: Theme.of(context).primaryColor,
                onPressed: () => _onSignUpTap(context),
                child: const Text("회원가입"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
