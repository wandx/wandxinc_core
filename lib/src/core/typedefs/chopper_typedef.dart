import 'package:chopper/chopper.dart';

typedef BodyParam = Future<Response<dynamic>> Function(
  Map<String, dynamic> body,
);

typedef BodyParamWithId = Future<Response<dynamic>> Function(
  String id,
  Map<String, dynamic> body,
);

typedef NoParam = Future<Response<dynamic>> Function();

typedef IdParam = Future<Response<dynamic>> Function(String id);
