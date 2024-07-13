import 'package:dio/dio.dart';
import 'package:krishi_vikas/local_storage/storage_service.dart';
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

    String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

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
      String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

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

    String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

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
