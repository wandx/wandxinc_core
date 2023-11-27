import 'package:chopper/chopper.dart';

extension ResponseExt on Response<dynamic> {
  bool get isSuccess => statusCode == 200;

  bool get isUnauthorized => statusCode == 401;

  bool get isForbidden => statusCode == 403;

  bool get isNotFound => statusCode == 404;

  bool get isServerError => statusCode == 500;

  bool get isBadRequest => statusCode == 400;

  bool get isUnprocessableEntity => statusCode == 422;

  bool get isNoInternetConnection => statusCode == 503;

  bool get isUnknownError => statusCode == 0;

  Map<String, dynamic> get mapData {
    final b = this.body as Map;
    final data = b['data'] as Map<String, dynamic>;
    return data;
  }

  Map<String, dynamic> get mapBody {
    final b = this.body as Map<String, dynamic>;
    return b;
  }

  List<Map<String, dynamic>> get mapListBody {
    final b = this.body as List;
    return b.map((e) => e as Map<String,dynamic>).toList();
  }

  List<Map<String, dynamic>> get mapListData {
    final b = this.body as Map;
    final data = b['data'] as List;
    return data.map((e) => e as Map<String, dynamic>).toList();
  }

  String get mapToken {
    final b = this.body as Map;
    final data = b['token'] as String;
    return data;
  }
}
