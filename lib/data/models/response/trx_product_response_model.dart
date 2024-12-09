import 'dart:convert';

class TrxProductResponse {
  final Meta? meta;
  final Data? data;

  TrxProductResponse({
    this.meta,
    this.data,
  });

  factory TrxProductResponse.fromJson(String str) =>
      TrxProductResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrxProductResponse.fromMap(Map<String, dynamic> json) =>
      TrxProductResponse(
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
  final String? mekanikId;
  final String? total;
  final String? alamat;
  final dynamic koordinat;
  final String? status;
  final String? jasaPasang;
  final String? pembayaran;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Item>? items;

  Transaction({
    this.id,
    this.userId,
    this.mekanikId,
    this.total,
    this.alamat,
    this.koordinat,
    this.status,
    this.jasaPasang,
    this.pembayaran,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  factory Transaction.fromJson(String str) =>
      Transaction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        userId: json["user_id"],
        mekanikId: json["mekanik_id"],
        total: json["total"],
        alamat: json["alamat"],
        koordinat: json["koordinat"],
        status: json["status"],
        jasaPasang: json["jasa_pasang"],
        pembayaran: json["pembayaran"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "mekanik_id": mekanikId,
        "total": total,
        "alamat": alamat,
        "koordinat": koordinat,
        "status": status,
        "jasa_pasang": jasaPasang,
        "pembayaran": pembayaran,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class Item {
  final int? id;
  final String? transactionProductId;
  final String? productId;
  final String? varian;
  final String? kuantitas;
  final String? harga;
  final String? total;
  final dynamic rating;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  Item({
    this.id,
    this.transactionProductId,
    this.productId,
    this.varian,
    this.kuantitas,
    this.harga,
    this.total,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        transactionProductId: json["transaction_product_id"],
        productId: json["product_id"],
        varian: json["varian"],
        kuantitas: json["kuantitas"],
        harga: json["harga"],
        total: json["total"],
        rating: json["rating"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "transaction_product_id": transactionProductId,
        "product_id": productId,
        "varian": varian,
        "kuantitas": kuantitas,
        "harga": harga,
        "total": total,
        "rating": rating,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toMap(),
      };
}

class Product {
  final int? id;
  final String? kode;
  final String? nama;
  final String? deskripsi;
  final String? varian;
  final String? harga;
  final String? status;
  final String? stok;
  final String? thumbnail;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    this.kode,
    this.nama,
    this.deskripsi,
    this.varian,
    this.harga,
    this.status,
    this.stok,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        varian: json["varian"],
        harga: json["harga"],
        status: json["status"],
        stok: json["stok"],
        thumbnail: json["thumbnail"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "kode": kode,
        "nama": nama,
        "deskripsi": deskripsi,
        "varian": varian,
        "harga": harga,
        "status": status,
        "stok": stok,
        "thumbnail": thumbnail,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
