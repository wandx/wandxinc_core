import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRequestInterceptor implements Interceptor {
  Request applyHeaders(
    Request request,
    Map<String, String> headers, {
    bool override = true,
  }) {
    final h = Map<String, String>.from(request.headers);

    for (final k in headers.keys) {
      if (!override && h.containsKey(k)) continue;
      h[k] = headers[k] ?? '';
    }

    return request.copyWith(headers: h);
  }

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final req = applyHeaders(chain.request, {'Authorization': 'Bearer $token'});
    return chain.proceed(req);
  }
}
