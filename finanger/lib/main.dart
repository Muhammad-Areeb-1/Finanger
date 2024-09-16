import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool firstTime = await isFirstTime();

  runApp(MyApp(firstTime: firstTime));
}

Future<bool> isFirstTime() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isFirstTime = pref.getBool('isFirstTime') ?? true;

  if (isFirstTime) {
    await pref.setBool('isFirstTime', false);
  }
  return isFirstTime;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.firstTime});
  final bool firstTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _buildTheme(),
      home: SplashScreen(
        isFirstTime: firstTime,
      ),
    );
  }
}

ThemeData _buildTheme() {
  final ThemeData base = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
      // ).copyWith(
      //   secondary: const Color.fromARGB(255, 37, 51, 204),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 245, 252, 244),
  );

  return base;

  // return base.copyWith(
  //   primaryColor: const Color.fromRGBO(255, 23, 68, 1),
  //   primaryColorLight: const Color(0xFFFF5252),
  //   primaryColorDark: const Color(0xFFD50000),
  //   secondaryHeaderColor: const Color(0xFFD32F2F),
  //   scaffoldBackgroundColor: Colors.white,
  //   hintColor: const Color.fromARGB(255, 37, 51, 204),
  //   cardColor: const Color(0xFF0D47A1),
  //   textTheme: _buildTextTheme(base.textTheme),
  //   primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  //   buttonTheme: ButtonThemeData(
  //     buttonColor: const Color(0xFFFF1744),
  //     textTheme: ButtonTextTheme.primary,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8.0),
  //     ),
  //   ),
  //   inputDecorationTheme: InputDecorationTheme(
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8.0),
  //       borderSide: const BorderSide(color: Color(0xFFFF1744)),
  //     ),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8.0),
  //       borderSide: const BorderSide(color: Color(0xFFFF1744)),
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8.0),
  //       borderSide: const BorderSide(color: Color(0xFFD32F2F)),
  //     ),
  //     labelStyle: const TextStyle(color: Color(0xFFD32F2F)),
  //     hintStyle: const TextStyle(color: Colors.black),
  //   ),
  //   appBarTheme: AppBarTheme(
  //     color: const Color(0xFFD32F2F),
  //     toolbarTextStyle: _buildTextTheme(base.primaryTextTheme)
  //         .bodyMedium
  //         ?.copyWith(color: Colors.white),
  //     titleTextStyle: _buildTextTheme(base.primaryTextTheme)
  //         .titleLarge
  //         ?.copyWith(color: Colors.white, fontSize: 24),
  //   ),
  //   colorScheme: const ColorScheme(
  //     primary: Color(0xFFFF1744),
  //     secondary: Color(0xFFD32F2F),
  //     secondaryContainer: Color(0xFFB71C1C),
  //     surface: Color(0xFF1A237E),
  //     error: Colors.red,
  //     onPrimary: Colors.black,
  //     onSecondary: Colors.black,
  //     onSurface: Colors.black,
  //     onError: Colors.black,
  //     brightness: Brightness.light,
  //   ),
  // );
}

// TextTheme _buildTextTheme(TextTheme base) {
//   return base.copyWith(
//     displayLarge: GoogleFonts.roboto(
//       fontSize: 72.0,
//       fontWeight: FontWeight.bold,
//     ),
//     titleLarge: GoogleFonts.roboto(
//       fontSize: 36.0,
//       fontStyle: FontStyle.italic,
//     ),
//     bodyMedium: GoogleFonts.openSans(
//       fontSize: 14.0,
//     ),
//     bodyLarge: GoogleFonts.openSans(
//       fontSize: 16.0,
//     ),
//     labelLarge: GoogleFonts.openSans(
//       fontSize: 16.0,
//       fontWeight: FontWeight.bold,
//     ),
//     // )
//     // .apply(
//     //   bodyColor: Colors.black,
//     //   displayColor: Colors.black,
//   );
// }
