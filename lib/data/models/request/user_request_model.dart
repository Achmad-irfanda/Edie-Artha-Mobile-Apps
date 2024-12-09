import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserRequestModel {
  final String name;
  final String email;
  final String nohp;
  final String alamat;
  final String? image;
  UserRequestModel({
    required this.name,
    required this.email,
    required this.nohp,
    required this.alamat,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'nohp': nohp,
      'alamat': alamat,
      'image': image,
    };
  }

  factory UserRequestModel.fromMap(Map<String, dynamic> map) {
    return UserRequestModel(
      name: map['name'] as String,
      email: map['email'] as String,
      nohp: map['nohp'] as String,
      alamat: map['alamat'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequestModel.fromJson(String source) =>
      UserRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
