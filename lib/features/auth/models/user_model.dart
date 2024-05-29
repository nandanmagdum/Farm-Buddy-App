
class UserModel {
  String? email;
  String? password;
  String? name;
  String? address;

  UserModel({this.email, this.password, this.name, this.address});

  UserModel.fromJson(Map<String, dynamic> json) {
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["password"] is String) {
      password = json["password"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["address"] is String) {
      address = json["address"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["email"] = email;
    _data["password"] = password;
    _data["name"] = name;
    _data["address"] = address;
    return _data;
  }
}