import 'package:dio/dio.dart';
import 'package:krishi_vikas/utils/api.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmLaboursServices {
  Dio dio = Dio();

  Future<bool> addRecord(
      String username,
      String aadhar_no,
      String email,
      String phone,
      String date_of_birth,
      String gender,
      String photo_url,
      String city,
      String state,
      String years_of_exp,
      String specialization,
      String daily_wage,
      String monthly_wage,
      String availability,
      String service_area) async {
    print("--- addRecord function is called --- ");

    print("-------------------------");

    print("""
                    username:    $username,
                    aadhar_no:    $aadhar_no,
                    email:   $email,
                    phone:   $phone,
                    date:     $date_of_birth,
                    gender:   $gender,
                    url:  $url,
                    city:    $city,
                    state:  $state,
                    years:    $years_of_exp,
                    spcialization:  $specialization,
                    daily_Wage:   $daily_wage,
                    monthly_wage:   $monthly_wage,
                    availability:   $availability,
                    service_area:   $service_area,""");

    print("-------------------------");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImF0aGFydmMyMDIyQGdtYWlsLmNvbSIsIm5hbWUiOiJBdGhhcnYiLCJfaWQiOiI2NjQ5YjQyNWY2NDhlMzgwOWVkOTYxNDMiLCJhZGRyZXNzIjoiOTQyMjMyNDkwMyIsImlhdCI6MTcxNjg1NTgyNywiZXhwIjoxNzE5NDQ3ODI3fQ.ENL-4Kl38ATfyE5BCx9Y2QRoE_JLxyNh4eebWqG0DAg";

    try {
      Response response = await dio.post("${base_url}labour/",
          data: {
            "username": username,
            "addhar_no": aadhar_no,
            "email": email,
            "phone": phone,
            "date_of_birth": date_of_birth,
            "gender": gender,
            "photo_url": url.toString(),
            "city": city,
            "state": state,
            "years_of_experience": years_of_exp,
            "specialization": specialization,
            "daily_wage": daily_wage,
            "monthly_wage": monthly_wage,
            "availability": availability,
            "service_area": service_area
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

  Future<dynamic> getFarmLabourRecord(String id) async {
    print("--- getFarmLabourRecord function is called ---");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token")!;
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwiX2lkIjoiNjY0NGViOTRjZDhkYzJmMDYwMjMzMDkyIiwiYWRkcmVzcyI6IkEvUDogQmFsaW5nZSwgVGFsOiBLYXJ2ZWVyLCBEaXN0OiBLb2xoYXB1ciwgNDE2MDEwIiwiaWF0IjoxNzE1NzkyODc0LCJleHAiOjE3MTgzODQ4NzR9.zebVbEiS4jM7cF0HryT-qQtUb878G_vA5VUkagdpJO0";

      Response response = await dio.get("${base_url}labour/$id",
          options: Options(headers: {"Authorization": token}));
      print(
          "Response statuscode : ${response.statusCode}  Response Data : ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<dynamic> getAllFarmLaboursRecords() async {
    print("--- getAllFarmLaboursRecords function is called ---");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwiX2lkIjoiNjY0NGViOTRjZDhkYzJmMDYwMjMzMDkyIiwiYWRkcmVzcyI6IkEvUDogQmFsaW5nZSwgVGFsOiBLYXJ2ZWVyLCBEaXN0OiBLb2xoYXB1ciwgNDE2MDEwIiwiaWF0IjoxNzE1NzkyODc0LCJleHAiOjE3MTgzODQ4NzR9.zebVbEiS4jM7cF0HryT-qQtUb878G_vA5VUkagdpJO0";
    try {
      Response response = await dio.get("${base_url}labour/all",
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
