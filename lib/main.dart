import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/router.dart';

/*  메모:
  릴리즈 설치: flutter run -d dante --release
  homebrew 말 안 들을 때: eval $(/opt/homebrew/bin/brew shellenv) 
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: PreciousPeople()));
}

class PreciousPeople extends ConsumerWidget {
  const PreciousPeople({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'PreciousPeople',
      // This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
      // theme: FlexThemeData.light(
      //   colors: const FlexSchemeColor(
      //     // primary: Color(0xffaae2d1),
      //     // primaryContainer: Color(0xffffffff),
      //     // secondary: Color(0xFFFFB7B7),
      //     // secondaryContainer: Color(0xFFFFB7B7),
      //     // tertiary: Color(0xFF25628D),
      //     // tertiaryContainer: Color(0xFF25628D),
      //     // appBarColor: Color(0xffffdbcf),
      //     // error: Color(0xffb00020),
      //     primary: Color(0xFFBFC88F),
      //     primaryContainer: Color(0xffffffff),
      //     secondary: Color(0xFFB4D7EB),
      //     secondaryContainer: Color(0xFFFFB7B7),
      //     tertiary: Color(0xFF25628D),
      //     tertiaryContainer: Color(0xFF25628D),
      //     appBarColor: Color(0xffffdbcf),
      //     error: Color(0xffb00020),
      //   ),
      //   surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      //   blendLevel: 9,
      //   subThemesData: const FlexSubThemesData(
      //     blendOnLevel: 10,
      //     blendOnColors: false,
      //   ),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   useMaterial3: true,
      //   swapLegacyOnMaterial3: true,

      //   // To use the playground font, add GoogleFonts package and uncomment
      //   // fontFamily: GoogleFonts.notoSans().fontFamily,
      // ),
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFFBFC88F),
        cupertinoOverrideTheme: const CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
          primaryColor: Color(0xFFBFC88F),
          dateTimePickerTextStyle: TextStyle(
            color: Color(0xFFBFC88F),
            fontSize: 16,
          ),
          pickerTextStyle: TextStyle(
            color: Color(0xFFBFC88F),
            fontSize: 12,
          ),
        )),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFBFC88F),
          primary: const Color(0xFFBFC88F),
          primaryContainer: const Color(0xffffffff),
          secondary: const Color(0xFFB4D7EB),
          secondaryContainer: const Color(0xFFFFB7B7),
          tertiary: const Color(0xFF25628D),
          tertiaryContainer: const Color(0xFF25628D),
          error: const Color(0xffb00020),
        ),
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xff9fc9ff),
          primaryContainer: Color(0xff00325b),
          secondary: Color(0xffffb59d),
          secondaryContainer: Color(0xff872100),
          tertiary: Color(0xff86d2e1),
          tertiaryContainer: Color(0xff004e59),
          appBarColor: Color(0xff872100),
          error: Color(0xffcf6679),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KO'),
        Locale('en', 'US'),
      ],
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
    );
  }
}
