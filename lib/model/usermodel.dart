
import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    required this.token,
  });

  String token;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toMap() => {
    "token": token == null ? null : token,
  };
}
