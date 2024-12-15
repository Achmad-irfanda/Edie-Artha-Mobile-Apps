import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:eam_app/common/constant/variables.dart';
import 'package:eam_app/data/datasource/auth_local_datasource.dart';
import 'package:eam_app/data/models/request/bengkel_request_model.dart';
import 'package:eam_app/data/models/response/bengkel_response_model.dart';
import 'package:eam_app/data/models/response/trx_bengkel_response_model.dart';
import 'package:eam_app/pages/bengkel/widget/text_area_bengkel.dart';

import 'package:http/http.dart' as http;

class BengkelRemoteDatesource {


  Future<Either<String, BengkelResponseModel>> transaction(
      BengkelRequestModel model) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}api/trx/workshop"),
      headers: headers,
      body: model.toJson(),
    );

    String filePath = valuesImageComp!;
    var gambar = await http.MultipartFile.fromPath('gambar', filePath);

    print('response $response'); 

    if (response.statusCode == 200) {
      return Right(BengkelResponseModel.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      return Left(mess);
    }
  }

  Future<Either<String, TrxBengkelResponseModel>> getAll(String status) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(
      Uri.parse("${Variables.baseUrl}api/trx/all-workshop?status=${status}"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(TrxBengkelResponseModel.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      return Left(mess);
    }
  }

  Future<bool> rating(int id, double rating) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}api/trx/workshop/rating"),
      headers: headers,
      body: jsonEncode({
        'trx_id': id,
        'rating': rating,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Either<String, BengkelResponseModel>> getTrx(String id) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(
      Uri.parse("${Variables.baseUrl}api/trx/workshop?id=${id}"),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return Right(BengkelResponseModel.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      return Left(mess);
    }
  }
}
