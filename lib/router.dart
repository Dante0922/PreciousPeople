import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/authentication/views/intro_screen.dart';
import 'package:precious_people/authentication/views/log_in_screen.dart';
import 'package:precious_people/authentication/views/sign_up_screen.dart';
import 'package:precious_people/authentication/views/splash_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/slpash",
      redirect: (context, state) {
        return null;
      },
      routes: [
        GoRoute(
          path: SplashScreen.routeUrl,
          name: SplashScreen.routeName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: IntroScreen.routeUrl,
          name: IntroScreen.routeName,
          builder: (context, state) => const IntroScreen(),
        ),
        GoRoute(
          path: SignUpScreen.routeUrl,
          name: SignUpScreen.routeName,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: LogInScreen.routeUrl,
          name: LogInScreen.routeName,
          builder: (context, state) => const LogInScreen(),
        ),
      ],
    );
  },
);
