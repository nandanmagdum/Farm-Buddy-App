import 'package:dio/dio.dart';
import 'package:krishi_vikas/local_storage/storage_service.dart';
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

    String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

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
     String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }

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
    String token =
        StorageService.pref.getString(StorageService.JWT) ?? "null";
    if(token == "null"){
      print("No token");
      throw Exception("Jwt Token not found");
    }
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
