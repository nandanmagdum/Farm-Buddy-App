import 'package:dio/dio.dart';
import 'package:krishi_vikas/local_storage/storage_service.dart';
import 'package:krishi_vikas/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimalServices {
  Dio dio = Dio();

  Future<bool> addRecord(String url, String animalType, String weight,
      String description, String color, String price, String location) async {
    print("--- addRecord function is called ---");
   String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

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
     String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

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
    String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }
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
