import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:wandxinc_core/wandxinc_core.dart';

/// OauthClientCredentialInterceptor is an interceptor that adds the Authorization header
/// to the request
class OauthClientCredentialInterceptor implements Interceptor {
  /// applyHeaders is a method that adds headers to the request
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
    final token = await WandxincCore.instance.getClientToken();
    final req = applyHeaders(chain.request, {'Authorization': 'Bearer $token'});
    return chain.proceed(req);
  }
}
