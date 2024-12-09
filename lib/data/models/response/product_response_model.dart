import 'dart:convert';

class ProductResponseModel {
  final Meta? meta;
  final Data? data;

  ProductResponseModel({
    this.meta,
    this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "meta": meta?.toMap(),
        "data": data?.toMap(),
      };
}

class Data {
  final List<Product>? products;

  Data({
    this.products,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toMap())),
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
  final Image? image;

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
    this.image,
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
        image: json["image"] == null ? null : Image.fromMap(json["image"]),
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
        "image": image?.toMap(),
      };
}

class Image {
  final String? image;

  Image({
    this.image,
  });

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "image": image,
      };
}

class Meta {
  final int? code;
  final String? status;
  final dynamic message;

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
