import 'package:dio/dio.dart';
import 'package:krishi_vikas/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimalServices {
  Dio dio = Dio();

  Future<bool> addRecord(String url, String animalType, String weight,
      String description, String color, String price, String location) async {
    print("--- addRecord function is called ---");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImF0aGFydmMyMDIyQGdtYWlsLmNvbSIsIm5hbWUiOiJBdGhhcnYiLCJfaWQiOiI2NjQ5YjQyNWY2NDhlMzgwOWVkOTYxNDMiLCJhZGRyZXNzIjoiOTQyMjMyNDkwMyIsImlhdCI6MTcxNjg1NTgyNywiZXhwIjoxNzE5NDQ3ODI3fQ.ENL-4Kl38ATfyE5BCx9Y2QRoE_JLxyNh4eebWqG0DAg";

    try {
      Response response = await dio.post("https://farm-buddy-backend.onrender.com/api/v1/animal/",
          data: {
            "photo_url": url,
            "animal_type": animalType,
            "weight": weight,
            "description": description,
            "color": color,
            "price": price,
            "location": location
          },
          options: Options(headers: {"Authorization": token}));

      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return true;
    } on DioException catch (e) {
      if (e.response != null) {
        print("################## $e");
      }
      return false;
      // throw Exception(e);
    }
  }

  Future<dynamic> getAnimalRecord(String id) async {
    print("--- getAnimalRecord function is called ---");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token")!;
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwiX2lkIjoiNjY0NGViOTRjZDhkYzJmMDYwMjMzMDkyIiwiYWRkcmVzcyI6IkEvUDogQmFsaW5nZSwgVGFsOiBLYXJ2ZWVyLCBEaXN0OiBLb2xoYXB1ciwgNDE2MDEwIiwiaWF0IjoxNzE1NzkyODc0LCJleHAiOjE3MTgzODQ4NzR9.zebVbEiS4jM7cF0HryT-qQtUb878G_vA5VUkagdpJO0";

      Response response = await dio.get("${base_url}animal/$id",
          options: Options(headers: {"Authorization": token}));
      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<dynamic> getAllAnimalRecords() async {
    print("--- getAllAnimalRecords function is called ---");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwiX2lkIjoiNjY0NGViOTRjZDhkYzJmMDYwMjMzMDkyIiwiYWRkcmVzcyI6IkEvUDogQmFsaW5nZSwgVGFsOiBLYXJ2ZWVyLCBEaXN0OiBLb2xoYXB1ciwgNDE2MDEwIiwiaWF0IjoxNzE1NzkyODc0LCJleHAiOjE3MTgzODQ4NzR9.zebVbEiS4jM7cF0HryT-qQtUb878G_vA5VUkagdpJO0";
    try {
      Response response = await dio.get("${base_url}animal/all",
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
