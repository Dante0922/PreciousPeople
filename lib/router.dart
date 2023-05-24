import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/authentication/views/intro_screen.dart';
import 'package:precious_people/features/authentication/views/logIn_choice_screen.dart';
import 'package:precious_people/features/authentication/views/signup_choice_screen.dart';
import 'package:precious_people/features/authentication/views/splash_screen.dart';
import 'package:precious_people/features/authentication/views/user_info_screen.dart';
import 'package:precious_people/features/memory/views/memory_detail_screen.dart';
import 'package:precious_people/features/memory/views/memory_list_screen.dart';
import 'package:precious_people/features/memory/views/save_notification_screen.dart';
import 'package:precious_people/features/settings/views/settings_screen.dart';
import 'package:precious_people/features/settings/views/user_setting_screen.dart';

import 'common/main_navigation_screen.dart';

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
          path: UserSettingScreen.routeUrl,
          name: UserSettingScreen.routeName,
          builder: (context, state) => const UserSettingScreen(),
        ),
        GoRoute(
          path: SettingsScreen.routeUrl,
          name: SettingsScreen.routeName,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: UserInfoScreen.routeUrl,
          name: UserInfoScreen.routeName,
          builder: (context, state) => const UserInfoScreen(),
        ),
        GoRoute(
          path: MemoryListScreen.routeUrl,
          name: MemoryListScreen.routeName,
          builder: (context, state) => const MemoryListScreen(),
          routes: [
            GoRoute(
              path: MemoryDetailScreen.routeUrl,
              name: MemoryDetailScreen.routeName,
              builder: (context, state) {
                final memoryDetailId = state.params["memoryDetailId"]!;
                return MemoryDetailScreen(
                  memoryDetailId: memoryDetailId,
                );
              },
            )
          ],
        ),
      ],
    );
  },
);
