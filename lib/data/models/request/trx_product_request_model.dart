import 'dart:convert';

class TrxProductRequestModel {
  final String alamat;
  final String jasaPasang;
  final String pembayaran;
  final List<Item> items;

  TrxProductRequestModel({
    required this.alamat,
    required this.jasaPasang,
    required this.pembayaran,
    required this.items,
  });

  factory TrxProductRequestModel.fromJson(String str) =>
      TrxProductRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrxProductRequestModel.fromMap(Map<String, dynamic> json) =>
      TrxProductRequestModel(
        alamat: json["alamat"],
        jasaPasang: json["jasa_pasang"],
        pembayaran: json["pembayaran"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "alamat": alamat,
        "jasa_pasang": jasaPasang,
        "pembayaran": pembayaran,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class Item {
  final int product;
  final int kuantitas;
  final String varian;

  Item({
    required this.product,
    required this.kuantitas,
    required this.varian,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        product: json["product"],
        kuantitas: json["kuantitas"],
        varian: json["varian"],
      );

  Map<String, dynamic> toMap() => {
        "product": product,
        "kuantitas": kuantitas,
        "varian": varian,
      };
}
