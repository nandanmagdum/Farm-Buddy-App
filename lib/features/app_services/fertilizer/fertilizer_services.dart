import 'package:dio/dio.dart';
import 'package:krishi_vikas/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FertilizerServices {
  Dio dio = Dio();

  Future<bool> addRecord(
      String url,
      String name,
      String weight,
      String coverage,
      String about,
      String price,
      String brand,
      String item_form,
      String specific_users) async {
    print("--- addRecord function is called ---");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwiX2lkIjoiNjY0NGViOTRjZDhkYzJmMDYwMjMzMDkyIiwiYWRkcmVzcyI6IkEvUDogQmFsaW5nZSwgVGFsOiBLYXJ2ZWVyLCBEaXN0OiBLb2xoYXB1ciwgNDE2MDEwIiwiaWF0IjoxNzE1NzkyODc0LCJleHAiOjE3MTgzODQ4NzR9.zebVbEiS4jM7cF0HryT-qQtUb878G_vA5VUkagdpJO0";

    try {
      Response response = await dio.post("${base_url}fertilizer/",
          data: {
            "photo_url": url,
            "name": name,
            "item_weight": weight,
            "coverage": coverage,
            "about_this_item": about,
            "price": price,
            "brand": brand,
            "item_form": item_form,
            "specific_users": specific_users
          },
          options: Options(headers: {"Authorization": token}));

      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return true;
    } catch (e) {
      print(e);
      return false;
      // throw Exception(e);
    }
  }

  Future<dynamic> getFertilizerRecord(String id) async {
    print("--- getFertilizerRecord function is called ---");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token")!;
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwiX2lkIjoiNjY0NGViOTRjZDhkYzJmMDYwMjMzMDkyIiwiYWRkcmVzcyI6IkEvUDogQmFsaW5nZSwgVGFsOiBLYXJ2ZWVyLCBEaXN0OiBLb2xoYXB1ciwgNDE2MDEwIiwiaWF0IjoxNzE1NzkyODc0LCJleHAiOjE3MTgzODQ4NzR9.zebVbEiS4jM7cF0HryT-qQtUb878G_vA5VUkagdpJO0";

      Response response = await dio.get("${base_url}fertilizer/$id",
          options: Options(headers: {"Authorization": token}));
      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<dynamic> getAllFertilizersRecords() async {
    print("--- getAllFertilizersRecords function is called ---");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwiX2lkIjoiNjY0NGViOTRjZDhkYzJmMDYwMjMzMDkyIiwiYWRkcmVzcyI6IkEvUDogQmFsaW5nZSwgVGFsOiBLYXJ2ZWVyLCBEaXN0OiBLb2xoYXB1ciwgNDE2MDEwIiwiaWF0IjoxNzE1NzkyODc0LCJleHAiOjE3MTgzODQ4NzR9.zebVbEiS4jM7cF0HryT-qQtUb878G_vA5VUkagdpJO0";

    try {
      Response response = await dio.get("${base_url}fertilizer/all",
          options: Options(headers: {"Authorization": token}));

      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
