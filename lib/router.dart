import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/authentication/views/introScreen.dart';
import 'package:precious_people/features/authentication/views/logInChoiceScreen.dart';
import 'package:precious_people/features/authentication/views/signUpChoiceScreen.dart';
import 'package:precious_people/features/authentication/views/splashScreen.dart';
import 'package:precious_people/features/memory/views/memoryDetailScreen.dart';
import 'package:precious_people/features/memory/views/saveNotificationScreen.dart';

import 'common/mainNavigationScreen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/home",
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
        GoRoute(
          path: "/:tab(home|friends|memories|settings)", // 받을 수 있는 파라미터를 제한함.
          name: MainNavigationScreen.routeName,
          builder: (context, state) {
            final tab = state.params["tab"]!;
            return MainNavigationScreen(
              tab: tab,
            );
          },
        ),
        GoRoute(
          path: SaveNotificationScreen.routeUrl,
          name: SaveNotificationScreen.routeName,
          builder: (context, state) => const SaveNotificationScreen(),
        ),
        GoRoute(
          path: MemoryDetailScreen.routeUrl,
          name: MemoryDetailScreen.routeName,
          builder: (context, state) => const MemoryDetailScreen(),
        )
      ],
    );
  },
);
