import 'package:dio/dio.dart';
import 'package:krishi_vikas/local_storage/storage_service.dart';
import 'package:krishi_vikas/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoilAnalysisServices {
  Dio dio = Dio();

  Future<bool> addRecord(
      String url,
      String name,
      String organization,
      String address,
      String city,
      String state,
      String zip,
      String country,
      String email,
      String phone) async {
    print("--- addRecord function is called ---");

   String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

    try {
      Response response = await dio.post("${base_url}soil/",
          data: {
            "photo_url": url,
            "name": name,
            "organization": organization,
            "address": address,
            "city": city,
            "state": state,
            "zip": zip,
            "country": country,
            "email": email,
            "phone": phone
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

  Future<dynamic> getSoilAnalysisRecord(String id) async {
    print("--- getSoilAnalysisRecord function is called ---");
    try {
      String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

      Response response = await dio.get("${base_url}soil/$id",
          options: Options(headers: {"Authorization": token}));
      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<dynamic> getAllSoilAnalysisRecords() async {
    print("--- getAllSoilAnalysisRecords function is called ---");

    String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }
    try {
      Response response = await dio.get("${base_url}soil/all",
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
