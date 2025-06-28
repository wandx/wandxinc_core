import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// WandxincCore is a singleton class that holds the core configuration of the
class WandxincCore {
  WandxincCore._();

  /// The instance of the WandxincCore
  static WandxincCore instance = WandxincCore._();

  /// The base URL of the API
  late String baseUrl;

  /// Enable HTTP logging
  bool enableHttpLogging = true;

  /// The list of services
  List<ChopperService> services = [];

  /// The list of services that require authentication
  List<ChopperService> authServices = [];

  /// The list of interceptors that require authentication
  /// first is the interceptor executed before process the error catch
  /// second is the interceptor
  List<(bool, Interceptor)> authInterceptors = [];

  /// The list of interceptors that require OAuth authentication
  /// first is the interceptor executed before process the error catch
  /// second is the interceptor
  List<(bool, Interceptor)> oauthClientInterceptors = [];

  /// The list of interceptors
  /// first is the interceptor executed before process the error catch
  /// second is the interceptor
  List<(bool, Interceptor)> interceptors = [];

  /// List of error message keys
  List<String> errorMessageKeys = [];

  /// Set token for authentication
  Future<void> setToken(String token) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString('token', token));
  }

  /// Set client token for authentication
  Future<void> setClientToken(String token) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString('client_token', token));
  }

  /// Get client token for authentication
  Future<String> getClientToken() async {
    return SharedPreferences.getInstance()
        .then((value) => value.getString('client_token') ?? '');
  }

  /// Clear client token for authentication
  Future<void> clearClientToken() async {
    await SharedPreferences.getInstance()
        .then((value) => value.remove('client_token'));
  }

  /// Set refresh token for authentication
  Future<void> setRefreshToken(String token) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString('refresh_token', token));
  }

  /// Get refresh token for authentication
  Future<String> getRefreshToken() async {
    return SharedPreferences.getInstance()
        .then((value) => value.getString('refresh_token') ?? '');
  }

  /// Clear refresh token for authentication
  Future<void> clearRefreshToken() async {
    await SharedPreferences.getInstance()
        .then((value) => value.remove('refresh_token'));
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
