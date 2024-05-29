import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krishi_vikas/features/auth/pages/login_or_register.dart';
import 'package:krishi_vikas/home_page.dart';
import 'package:krishi_vikas/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  final bool isHome;
  const SplashScreen({super.key, required this.isHome});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      if (widget.isHome) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginOrRegister(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_green,
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 500.0),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/splash_screen.jpg",
                  height: value,
                ),
                Opacity(
                  opacity: value / 500,
                  child: Text("FarmBuddy",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
