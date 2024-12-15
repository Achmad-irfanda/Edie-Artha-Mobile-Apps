
import 'package:eam_app/data/models/response/auth_response_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String dateNow = DateTime.now().toString();
DateFormat dateFrormats = DateFormat("dd/MM/yyyy");

class AuthLocalDatasource {
  Future<bool> saveAuthData(AuthResponseModel model) async {
    final pref = await SharedPreferences.getInstance();
    final result = await pref.setString('auth', model.toJson());
    return result;
  }

  Future<bool> removeAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final result = await pref.remove('auth');
    return result;
  }

  Future<AuthResponseModel?> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final authData = pref.getString('auth');
    if (authData != null) {
      return AuthResponseModel.fromJson(authData);
    } else {
      return null;
    }
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    final authModel = AuthResponseModel.fromJson(authJson);
    return authModel.data?.accessToken;
  }

  Future<bool> isLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    return authJson.isNotEmpty;
  }

  // Future saveEmailPass({
  //   required email,
  //   required passw,
  // }) async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   await sp.setString("lastLogin", dateNow);
  //   await sp.setString('email', email);
  //   await sp.setString('password', passw);
  // }
}
