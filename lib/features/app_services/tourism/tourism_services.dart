import 'package:dio/dio.dart';
import 'package:krishi_vikas/local_storage/storage_service.dart';
import 'package:krishi_vikas/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TourismServices {
  Dio dio = Dio();

  Future<bool> addRecord(
    String photo_url,
    String farm_name,
    String owner_name,
    String email,
    String phone,
    String address,
    String description,
    String farm_specialization,
    String availability,
    String check_in,
    String check_out,
    String total_price,
  ) async {
    print("--- addRecord function is called ---");

    String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

    try {
      Response response = await dio.post("${base_url}tourism/",
          data: {
            "photo_url": photo_url,
            "farm_name": farm_name,
            "owner_name": owner_name,
            "email": email,
            "phone": phone,
            "address": address,
            "description": description,
            "farm_specialization": farm_specialization,
            "availability": availability,
            "check_in": check_in,
            "check_out": check_out,
            "total_price": total_price
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

  Future<dynamic> getTourismRecord(String id) async {
    print("--- getTourismRecord function is called ---");
    try {
      String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

      Response response = await dio.get("${base_url}tourism/$id",
          options: Options(headers: {"Authorization": token}));
      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<dynamic> getAllTourismRecords() async {
    print("--- getAllTourismRecords function is called ---");

    String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }
    try {
      Response response = await dio.get("${base_url}tourism/all",
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
