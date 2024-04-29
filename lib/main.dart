import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notedo_app/views/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  void changeAppTheme() {
    isDarkTheme = !isDarkTheme;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notedo App',
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 254, 249, 255),
          brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomeScreen(
        changeAppTheme: () {
          setState(() {
            changeAppTheme();
          });
        },
        isWhiteMode: !isDarkTheme,
      ),
      // home: TranslatorScreen(),
    );
  }
}
