import 'dart:convert';

class RegisterEntity {
  RegisterEntity({
    required this.token,
    required this.authData,
  });

  final String token;
  final String authData;
  factory RegisterEntity.fromJson(String str) => RegisterEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterEntity.fromMap(Map<String, dynamic> json) => RegisterEntity(
    token: json["token"],
    authData: json["auth_data"],
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "auth_token": authData,
  };
}