import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wandxinc_core/src/core/core.dart';
import 'package:wandxinc_core/src/wandxinc_core.dart';

class Oat {
  static const tokenUrl = String.fromEnvironment('OAUTH_BASE_URL');
  static const clientId = String.fromEnvironment('OAUTH_CLIENT_ID');
  static const clientSecret = String.fromEnvironment('OAUTH_CLIENT_SECRET');

  Uri get tokenUri => Uri.parse('$tokenUrl/oauth/token');

  Future<Either<OatException, (int, String)>> getClientAccessToken() async {
    _validateSatisfy();

    final header = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = <String, dynamic>{
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret,
    };

    try {
      final response = await http.post(tokenUri, headers: header, body: body);
      final bodyString = response.body;
      final json = jsonDecode(bodyString) as Map<String, dynamic>;
      final token = json['access_token'] as String;
      final expiresIn = json['expires_in'] as int;

      await WandxincCore.instance.setClientToken(token);

      return right((expiresIn, token));
    } catch (e) {
      return left(OatException(message: e.toString()));
    }
  }

  Future<Either<OatException, (int, String, String)>> getAccessToken({
    required String username,
    required String password,
  }) async {
    _validateSatisfy();

    final clientToken = await WandxincCore.instance.getClientToken();

    final header = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $clientToken',
    };

    final body = <String, dynamic>{
      'grant_type': 'password',
      'client_id': clientId,
      'client_secret': clientSecret,
      'username': username,
      'password': password,
    };

    try {
      final response = await http.post(tokenUri, headers: header, body: body);
      final bodyString = response.body;
      final json = jsonDecode(bodyString) as Map<String, dynamic>;
      final token = json['access_token'] as String;
      final refreshToken = json['refresh_token'] as String;
      final expiresIn = json['expires_in'] as int;

      await WandxincCore.instance.setToken(token);
      await WandxincCore.instance.setRefreshToken(refreshToken);

      return right((expiresIn, token, refreshToken));
    } catch (e) {
      return left(OatException(message: e.toString()));
    }
  }

  Future<Either<OatException, (int, String, String)>> refershToken() async {
    _validateSatisfy();

    final clientToken = await WandxincCore.instance.getClientToken();

    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token') ?? '';

    if (refreshToken.isEmpty) {
      return left(OatException(message: 'Refresh token is empty'));
    }

    final header = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $clientToken',
    };

    final body = <String, dynamic>{
      'grant_type': 'refresh_token',
      'client_id': clientId,
      'client_secret': clientSecret,
      'refresh_token': refreshToken,
    };

    try {
      final response = await http.post(tokenUri, headers: header, body: body);
      final bodyString = response.body;
      final json = jsonDecode(bodyString) as Map<String, dynamic>;
      final token = json['access_token'] as String;
      final refreshToken = json['refresh_token'] as String;
      final expiresIn = json['expires_in'] as int;

      await WandxincCore.instance.setToken(token);
      await WandxincCore.instance.setRefreshToken(refreshToken);

      return right((expiresIn, token, refreshToken));
    } catch (e) {
      return left(OatException(message: e.toString()));
    }
  }

  void _validateSatisfy() {
    if (tokenUrl.isEmpty) {
      throw Exception('Token URL is empty');
    }

    if (clientId.isEmpty) {
      throw Exception('Client ID is empty');
    }

    if (clientSecret.isEmpty) {
      throw Exception('Client Secret is empty');
    }
  }
}

class OatException extends BaseException {
  OatException({required super.message});
}
