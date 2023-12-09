import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template wandxinc_core}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WandxincCore {
  WandxincCore._();

  static WandxincCore instance = WandxincCore._();

  String baseUrl = '';

  List<ChopperService> services = [];

  List<ChopperService> authServices = [];

  Future<void> setToken(String token) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString('token', token));
  }

  Future<String> getToken() async {
    return SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
  }

  Future<void> clearToken() async {
    await SharedPreferences.getInstance()
        .then((value) => value.remove('token'));
  }
}
