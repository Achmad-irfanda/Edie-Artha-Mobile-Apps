import 'dart:convert';

class TrxBengkelResponseModel {
  final Meta? meta;
  final Data? data;

  TrxBengkelResponseModel({
    this.meta,
    this.data,
  });

  factory TrxBengkelResponseModel.fromJson(String str) =>
      TrxBengkelResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrxBengkelResponseModel.fromMap(Map<String, dynamic> json) =>
      TrxBengkelResponseModel(
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "meta": meta?.toMap(),
        "data": data?.toMap(),
      };
}

class Data {
  final List<Transaction>? transaction;

  Data({
    this.transaction,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        transaction: json["transaction"] == null
            ? []
            : List<Transaction>.from(
                json["transaction"]!.map((x) => Transaction.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "transaction": transaction == null
            ? []
            : List<dynamic>.from(transaction!.map((x) => x.toMap())),
      };
}

class Transaction {
  final int? id;
  final String? userId;
  final String? alamat;
  final String? kendala;
  final String? deskripsi;
  final String? jenisKendaraan;
  final String? platNomor;
  final String? rating;
  final String? status;
  final DateTime? createdAt;
  final Mekanik? mekanik;

  Transaction({
    this.id,
    this.userId,
    this.alamat,
    this.kendala,
    this.deskripsi,
    this.jenisKendaraan,
    this.platNomor,
    this.rating,
    this.status,
    this.createdAt,
    this.mekanik,
  });

  factory Transaction.fromJson(String str) =>
      Transaction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        userId: json["user_id"],
        alamat: json["alamat"],
        kendala: json["kendala"],
        deskripsi: json["deskripsi"],
        jenisKendaraan: json["jenis_kendaraan"],
        platNomor: json["plat_nomor"],
        rating: json["rating"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        mekanik:
            json["mekanik"] == null ? null : Mekanik.fromMap(json["mekanik"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "alamat": alamat,
        "kendala": kendala,
        "deskripsi": deskripsi,
        "jenis_kendaraan": jenisKendaraan,
        "plat_nomor": platNomor,
        "rating": rating,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "mekanik": mekanik?.toMap(),
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
