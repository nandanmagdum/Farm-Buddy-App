import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:krishi_vikas/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/models/user_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This function will fetch the token from local storage if it is present
  /// else it will return false
  Future<bool> fetchToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token").toString();

    if (token.isEmpty) {
      return false;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    UserModel user = UserModel(
      email: decodedToken["email"],
      name: decodedToken["name"],
      address: decodedToken["address"],
    );

    sharedPreferences.setString("userInfo", jsonEncode(user));

    return true;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
        designSize: Size(width, height),
        builder: (_, context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                fontFamily: "poppins"),
            home: FutureBuilder(
              future: fetchToken(),
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return const SplashScreen(isHome: true);
                } else {
                  return const SplashScreen(isHome: false);
                }
              },
            ),
          );
        });
  }
}
