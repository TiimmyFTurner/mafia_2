import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_2/applications/state_management/shared_preferences_provider.dart';
import 'package:mafia_2/infrastructure/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  return runApp(ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    child: const Mafia2App(),
  ));
}

class Mafia2App extends StatelessWidget {
  const Mafia2App({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme defaultLightColorScheme =
        ColorScheme.fromSeed(seedColor: Colors.tealAccent);
    final ColorScheme defaultDarkColorScheme = ColorScheme.fromSeed(
        seedColor: Colors.tealAccent, brightness: Brightness.dark);
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp.router(
            routerConfig: router,
            title: 'Mafia 2',
            theme: ThemeData(
                colorScheme: lightColorScheme ?? defaultLightColorScheme,
                useMaterial3: true,
                fontFamily: 'Koodak'),
            darkTheme: ThemeData(
                colorScheme: darkColorScheme ?? defaultDarkColorScheme,
                useMaterial3: true,
                fontFamily: 'Koodak'),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
            ],
            locale: const Locale("fa", "IR"));
      },
    );
  }
}
