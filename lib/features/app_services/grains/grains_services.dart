import 'package:dio/dio.dart';
import 'package:krishi_vikas/local_storage/storage_service.dart';
import 'package:krishi_vikas/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrainServices {
  Dio dio = Dio();

  Future<bool> addRecord(
    String name,
    String photo_url,
    String weight,
    String no_of_items,
    String location,
    String description,
    String price_in_kg,
    String brand,
    String diet_type,
    String net_quantity,
    String contact,
  ) async {
    print("--- addRecord function is called ---");
    String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }
    try {
      Response response = await dio.post("${base_url}grains/",
          data: {
            "name": name,
            "photo_url": photo_url,
            "weight": weight,
            "no_of_items": no_of_items,
            "location": location,
            "description": description,
            "price_in_kg": price_in_kg,
            "brand": brand,
            "diet_type": diet_type,
            "net_quantity": net_quantity,
            "contact": contact
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

  Future<dynamic> getGrainRecord(String id) async {
    print("--- getGrainRecord function is called ---");
    try {
     String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

      Response response = await dio.get("${base_url}grains/$id",
          options: Options(headers: {"Authorization": token}));
      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<dynamic> getAllGrainRecords() async {
    print("--- getAllGrainRecords function is called ---");

   String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }
    try {
      Response response = await dio.get("${base_url}grains/all",
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
