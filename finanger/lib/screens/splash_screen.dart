import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_screen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.isFirstTime});
  final bool isFirstTime;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashSerivces _splashSerivces = SplashSerivces();

  @override
  void initState() {
    super.initState();
    _splashSerivces.navigator(context, widget.isFirstTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200, child: SvgPicture.asset('assets/logo.svg')),
            const SizedBox(height: 40),
            Text(
              'Finanger',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class SplashSerivces {
  void navigator(BuildContext context, bool isFirstTime) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                isFirstTime ? const WelcomeScreen() : const LoginScreen()),
      ),
    );
  }
}
