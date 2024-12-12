import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:eam_app/common/constant/variables.dart';
import 'package:eam_app/data/datasource/auth_local_datasource.dart';
import 'package:eam_app/data/models/request/trx_product_request_model.dart';
import 'package:eam_app/data/models/response/product_response_model.dart';
import 'package:eam_app/data/models/response/trx_product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> product() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(
      Uri.parse("${Variables.baseUrl}api/products"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      print("mess $mess"); 
      return Left(mess);
    }
  }

  Future<Either<String, ProductResponseModel>> getProduct(String query) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(
      Uri.parse("${Variables.baseUrl}api/product?search=$query"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      return Left(mess);
    }
  }

  Future<Either<String, TrxProductResponse>> transaction(
      TrxProductRequestModel model) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}api/trx/product"),
      headers: headers,
      body: model.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(TrxProductResponse.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      return Left(mess);
    }
  }

  Future<Either<String, TrxProductResponse>> getTrx(String id) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(
      Uri.parse("${Variables.baseUrl}api/trx/product?id=${id}"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(TrxProductResponse.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      return Left(mess);
    }
  }

  Future<Either<String, TrxProductResponse>> getAll(String status) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(
      Uri.parse("${Variables.baseUrl}api/trx/all-product?status=${status}"),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return Right(TrxProductResponse.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      return Left(mess);
    }
  }
}
