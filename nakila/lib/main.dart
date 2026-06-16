import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(

  ChangeNotifierProvider(
    create: (_) => ThemeProvider(),

    child: const NakilaApp(),
  ),
);
}

class NakilaApp extends StatelessWidget {
  const NakilaApp({super.key});

  @override
Widget build(BuildContext context) {

  return Consumer<ThemeProvider>(
    builder: (
      context,
      theme,
      child,
    ) {

      return MaterialApp(
        title: 'NAKILA',

        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor:
              Colors.white,
        ),

        darkTheme: ThemeData(
          useMaterial3: true,

          brightness:
              Brightness.dark,

          scaffoldBackgroundColor:
              const Color(
            0xff0F172A,
          ),
        ),

        themeMode:
            theme.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,

        home:
            const SplashScreen(),
      );
    },
  );
}
}