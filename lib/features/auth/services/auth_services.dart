
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/api.dart';
import '../models/user_model.dart';

class AuthService {
  Dio dio = Dio();

  /// login user

  Future<void> loginUser(String email, String password, BuildContext context) async {
    debugPrint("Login function is called");
    try {
      Response response = await dio.post("${base_url}auth/login", data: {
        "email": email,
        "password": password,
      });
      print("*************************************");
      print(response.data);

      String token = response.data["token"];
      print("Token : $token");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", token);
    } on DioException catch (e) {
      if(e.response != null){
        if(e.response!.statusCode == 400){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.response!.data)));
        }
      } else {
        print(e.message);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      }
      debugPrint("Login Exception -->  $e");
      throw Exception(e);
    }
  }

  /// send OTP

  Future<void> sendOTP(UserModel user) async {
    debugPrint("Send OTP function is called");

    try {
      debugPrint("Sending OTP...");

      Response response = await dio.post("${base_url}auth/send_otp", data: {
        "email": user.email,
        "password": user.password,
        "name": user.name,
        "address": user.address
      });
      debugPrint("OTP sent successfully");
      debugPrint(
          "Send OTP API response : StatusCode :  ${response.statusCode}  Response :  ${response.data} ");
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  /// verify OTP

  Future<int> verifyOTP(String email, String otp, BuildContext context) async {
    debugPrint("Verify OTP function is called");
    debugPrint("Verifying the OTP for email : $email and  otp : $otp");
    Response response = Response(requestOptions: RequestOptions());

    try {
      response = await dio.post("${base_url}auth/verify",
          data: {"clientEmail": email, "clientOTP": otp});

      debugPrint("OTP verified successfully");
      debugPrint("Response Status Code -> ${response.statusCode}");
      return response.statusCode!;
    } on DioException catch (e) {
      debugPrint("dio Error Response Status Code -> ${response.statusCode}");
    } catch(e){
      debugPrint("catch Error Response Status Code -> ${response.statusCode}");

    }
    return response.statusCode!;
  }

  /// register - creater new user

  // Future<int> createNewUser(UserModel user) async {
  //   debugPrint("CreateNewUser function is called");
  //   Response response;
  //   try {
  //     List<String> l = ["Asd", "asd"];
  //     response = await dio.post("${base_url}auth/createNewUser", data: {
  //       "list": l,
  //       "name": user.name,
  //       "address": user.address,
  //       "email": user.email,
  //       "password": user.password,
  //     });

  //     debugPrint("Response StatusCode :  ${response.statusCode}");
  //     print("Response :  ${response.data}");
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     throw Exception(e);
  //   }
  //   return response.statusCode!;
  // }
}
