import 'dart:convert';

class BengkelResponseModel {
  final Meta meta;
  final Data data;

  BengkelResponseModel({
    required this.meta,
    required this.data,
  });

  factory BengkelResponseModel.fromRawJson(String str) =>
      BengkelResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BengkelResponseModel.fromJson(Map<String, dynamic> json) =>
      BengkelResponseModel(
        meta: Meta.fromJson(json["meta"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final Transaction transaction;

  Data({
    required this.transaction,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transaction: Transaction.fromJson(json["transaction"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction": transaction.toJson(),
      };
}

class Transaction {
  final int id;
  final int userId;
  final dynamic mekanikId;
  final String alamat;
  final String kendala;
  final String deskripsi;
  final String jenisKendaraan;
  final String platNomor;
  final dynamic rating;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String gambar;
  final Mekanik? mekanik;

  Transaction({
    required this.id,
    required this.userId,
    required this.mekanikId,
    required this.alamat,
    required this.kendala,
    required this.deskripsi,
    required this.jenisKendaraan,
    required this.platNomor,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.gambar,
    this.mekanik,
  });

  factory Transaction.fromRawJson(String str) =>
      Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        userId: json["user_id"],
        mekanikId: json["mekanik_id"],
        alamat: json["alamat"],
        kendala: json["kendala"],
        deskripsi: json["deskripsi"],
        jenisKendaraan: json["jenis_kendaraan"],
        platNomor: json["plat_nomor"],
        rating: json["rating"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        gambar: json["gambar"],
        mekanik:
            json["mekanik"] == null ? null : Mekanik.fromMap(json["mekanik"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "mekanik_id": mekanikId,
        "alamat": alamat,
        "kendala": kendala,
        "deskripsi": deskripsi,
        "jenis_kendaraan": jenisKendaraan,
        "plat_nomor": platNomor,
        "rating": rating,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "gambar": gambar,
        "mekanik": mekanik,
      };
}

class Meta {
  final int code;
  final String status;
  final String message;

  Meta({
    required this.code,
    required this.status,
    required this.message,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
      };
}

class Mekanik {
  final int? id;
  final String? nama;
  final String? nohp;
  final String? jabatan;
  final String? image;

  Mekanik({
    this.id,
    this.nama,
    this.nohp,
    this.jabatan,
    this.image,
  });

  factory Mekanik.fromJson(String str) => Mekanik.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mekanik.fromMap(Map<String, dynamic> json) => Mekanik(
        id: json["id"],
        nama: json["nama"],
        nohp: json["nohp"],
        jabatan: json["jabatan"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nama": nama,
        "nohp": nohp,
        "jabatan": jabatan,
        "image": image,
      };
}
