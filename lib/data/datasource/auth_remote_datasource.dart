import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:eam_app/data/datasource/auth_local_datasource.dart';
import 'package:eam_app/data/models/request/user_request_model.dart';
import 'package:eam_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/variables.dart';
import '../models/request/register_request_model.dart';
import '../models/response/user_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final response = await http.post(Uri.parse("${Variables.baseUrl}api/login"),
        body: {
          'email': email,
          'password': password,
        },
        headers: headers);

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['data']['message'];
      return Left(mess);
    }
  }

  Future<Either<String, String>> logout() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}api/logout"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final mess = jsonDecode(response.body)['meta']['status'];
      return Right(mess);
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      return Left(mess);
    }
  }

  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel model) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final response = await http.post(
        Uri.parse("${Variables.baseUrl}api/register"),
        headers: headers,
        body: model.toJson());

    print("res regist ${response.body}");
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['data']['message'];
      return Left(mess);
    }
  }

  Future<Either<String, UserResponseModel>> getUser() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(
      Uri.parse("${Variables.baseUrl}api/user"),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return Right(UserResponseModel.fromJson(response.body));
    } else {
      final mess = jsonDecode(response.body)['meta']['message'];
      return Left(mess);
    }
  }

  Future<Either<String, UserResponseModel>> update(
      UserRequestModel model) async {
    final token = await AuthLocalDatasource().getToken();
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Variables.baseUrl}api/update-profile"));
    request.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    request.fields['name'] = model.name;
    request.fields['email'] = model.email;
    request.fields['nohp'] = model.nohp;
    request.fields['alamat'] = model.alamat;

    if (model.image != '') {
      request.files
          .add(await http.MultipartFile.fromPath('image', model.image!));
    }

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return Right(UserResponseModel.fromJson(respStr));
    } else {
      final mess = jsonDecode(respStr)['meta']['message'];
      return Left(mess);
    }
  }

  Future<Either<String, String>> changePassword(password, newPassword) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var body = jsonEncode({
      'password': password,
      'new_password': newPassword,
    });

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}api/change-password"),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      final mess = jsonDecode(response.body)['data']['message'];
      return Right(mess);
    } else {
      final mess = jsonDecode(response.body)['data']['message'];
      return Left(mess);
    }
  }
}
