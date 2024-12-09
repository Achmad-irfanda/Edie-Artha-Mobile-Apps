import 'dart:convert';

class UserResponseModel {
  final Meta? meta;
  final Data? data;

  UserResponseModel({
    this.meta,
    this.data,
  });

  factory UserResponseModel.fromJson(String str) =>
      UserResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromMap(Map<String, dynamic> json) =>
      UserResponseModel(
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "meta": meta?.toMap(),
        "data": data?.toMap(),
      };
}

class Data {
  final User? user;

  Data({
    this.user,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "user": user?.toMap(),
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
    this.id,
    this.name,
    this.email,
    this.nohp,
    this.alamat,
    this.jk,
    this.image,
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
    this.code,
    this.status,
    this.message,
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
