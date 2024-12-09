import 'package:meta/meta.dart';
import 'dart:convert';

class AuthResponseModel {
  final Meta? meta;
  final Data? data;

  AuthResponseModel({
    required this.meta,
    required this.data,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        meta: Meta.fromMap(json["meta"]),
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "meta": meta?.toMap(),
        "data": data?.toMap(),
      };
}

class Data {
  final String accessToken;
  final String tokenType;
  final User user;

  Data({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "user": user.toMap(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? nohp;
  final String? alamat;
  final String? jk;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.nohp,
    required this.alamat,
    required this.jk,
    required this.image,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        nohp: json["nohp"],
        alamat: json["alamat"],
        jk: json["jk"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "nohp": nohp,
        "alamat": alamat,
        "jk": jk,
        "image": image,
      };
}

class Meta {
  final int? code;
  final String? status;
  final String? message;

  Meta({
    required this.code,
    required this.status,
    required this.message,
  });

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        code: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "message": message,
      };
}
