import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// WandxincCore is a singleton class that holds the core configuration of the
class WandxincCore {
  WandxincCore._();

  /// The instance of the WandxincCore
  static WandxincCore instance = WandxincCore._();

  /// The base URL of the API
  String baseUrl = '';

  /// The list of services
  List<ChopperService> services = [];

  /// The list of services that require authentication
  List<ChopperService> authServices = [];

  /// The list of interceptors that require authentication
  List<Interceptor> authInterceptors = [];

  /// The list of interceptors
  List<Interceptor> interceptors = [];

  /// Set token for authentication
  Future<void> setToken(String token) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString('token', token));
  }

  /// Get token for authentication
  Future<String> getToken() async {
    return SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
  }

  /// Clear token for authentication
  Future<void> clearToken() async {
    await SharedPreferences.getInstance()
        .then((value) => value.remove('token'));
  }
}
