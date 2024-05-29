import 'package:dio/dio.dart';
import 'package:krishi_vikas/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EquipmentServices {
  Dio dio = Dio();

  Future<bool> addRecord(
      String url,
      String name,
      String material,
      String location,
      String description,
      String price,
      String brand,
      String weight,
      String contact,
      String delivery_status) async {
    print("--- addRecord function is called ---");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImF0aGFydmMyMDIyQGdtYWlsLmNvbSIsIm5hbWUiOiJBdGhhcnYiLCJfaWQiOiI2NjQ5YjQyNWY2NDhlMzgwOWVkOTYxNDMiLCJhZGRyZXNzIjoiOTQyMjMyNDkwMyIsImlhdCI6MTcxNjg1NTgyNywiZXhwIjoxNzE5NDQ3ODI3fQ.ENL-4Kl38ATfyE5BCx9Y2QRoE_JLxyNh4eebWqG0DAg";

    print("""
    url $url
    name $name
    material $material 
    location $location
    description $description
    price $price
    brand $brand
    weight $weight
    contact $contact
    delivery_status $delivery_status
 """);

    try {
      Response response = await dio.post("${base_url}equipment/",
          data: {
            "photo_url": url,
            "name": name,
            "material": material,
            "location": location,
            "description": description,
            "price": price,
            "brand": brand,
            "weight": weight,
            "contact": contact,
            "delivery_status": delivery_status
          },
          options: Options(headers: {"Authorization": token}));

      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return true;
    } on DioException catch (e) {
      print(e);
      return false;
      // throw Exception(e);
    }
  }

  Future<dynamic> getEquipmentRecord(String id) async {
    print("--- getEquipmentRecord function is called ---");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token")!;
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwiX2lkIjoiNjY0NGViOTRjZDhkYzJmMDYwMjMzMDkyIiwiYWRkcmVzcyI6IkEvUDogQmFsaW5nZSwgVGFsOiBLYXJ2ZWVyLCBEaXN0OiBLb2xoYXB1ciwgNDE2MDEwIiwiaWF0IjoxNzE1NzkyODc0LCJleHAiOjE3MTgzODQ4NzR9.zebVbEiS4jM7cF0HryT-qQtUb878G_vA5VUkagdpJO0";

      Response response = await dio.get("${base_url}equipment/$id",
          options: Options(headers: {"Authorization": token}));
      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<dynamic> getAllEquipmentRecords() async {
    print("--- getAllEquipmentRecords function is called ---");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwiX2lkIjoiNjY0NGViOTRjZDhkYzJmMDYwMjMzMDkyIiwiYWRkcmVzcyI6IkEvUDogQmFsaW5nZSwgVGFsOiBLYXJ2ZWVyLCBEaXN0OiBLb2xoYXB1ciwgNDE2MDEwIiwiaWF0IjoxNzE1NzkyODc0LCJleHAiOjE3MTgzODQ4NzR9.zebVbEiS4jM7cF0HryT-qQtUb878G_vA5VUkagdpJO0";
    try {
      Response response = await dio.get("${base_url}equipment/all",
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
