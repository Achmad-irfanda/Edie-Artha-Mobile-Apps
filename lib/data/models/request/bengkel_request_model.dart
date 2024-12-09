import 'dart:convert';

class BengkelRequestModel {
  final String alamat;
  final String kendala;
  final String deskripsi;
  final String kendaraan;
  final String platNomor;
  BengkelRequestModel({
    required this.alamat,
    required this.kendala,
    required this.deskripsi,
    required this.kendaraan,
    required this.platNomor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deskripsi': deskripsi,
      'alamat': alamat,
      'kendala': kendala,
      'jenis_kendaraan': kendaraan,
      'plat_nomor': platNomor,
    };
  }

  factory BengkelRequestModel.fromMap(Map<String, dynamic> map) {
    return BengkelRequestModel(
      alamat: map['alamat'] as String,
      kendala: map['kendala'] as String,
      deskripsi: map['deskripsi'] as String,
      kendaraan: map['jenis_kendaraan'] as String,
      platNomor: map['plat_nomor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BengkelRequestModel.fromJson(String source) =>
      BengkelRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
