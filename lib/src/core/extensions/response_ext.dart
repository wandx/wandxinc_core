import 'package:chopper/chopper.dart';

/// Extension on Response to check the status code of the response
extension ResponseExt on Response<dynamic> {
  /// Check if the response is successful
  bool get isSuccess => statusCode == 200;

  /// Check if the response is unauthorized
  bool get isUnauthorized => statusCode == 401;

  /// Check if the response is forbidden
  bool get isForbidden => statusCode == 403;

  /// Check if the response is not found
  bool get isNotFound => statusCode == 404;

  /// Check if the response is a server error
  bool get isServerError => statusCode == 500;

  /// Check if the response is a bad request
  bool get isBadRequest => statusCode == 400;

  /// Check if the response is a conflict
  bool get isUnprocessableEntity => statusCode == 422;

  /// Check if the response is a no internet connection
  bool get isNoInternetConnection => statusCode == 503;

  /// Check if the response is an unknown error
  bool get isUnknownError => statusCode == 0;

  /// Convert object inside data object to map
  Map<String, dynamic> get mapData {
    final b = this.body as Map;
    final data = b['data'] as Map<String, dynamic>;
    return data;
  }

  /// Convert object inside body to map
  Map<String, dynamic> get mapBody {
    final b = this.body as Map<String, dynamic>;
    return b;
  }

  /// Convert object inside body to list
  List<Map<String, dynamic>> get mapListBody {
    final b = this.body as List;
    return b.map((e) => e as Map<String, dynamic>).toList();
  }

  /// Convert object inside data object to list
  List<Map<String, dynamic>> get mapListData {
    final b = this.body as Map;
    final data = b['data'] as List;
    return data.map((e) => e as Map<String, dynamic>).toList();
  }

  /// Get token from the response
  String get mapToken {
    final b = this.body as Map;
    final data = b['token'] as String;
    return data;
  }
}
