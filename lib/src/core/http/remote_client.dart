import 'package:chopper/chopper.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';
import 'package:wandxinc_core/src/core/http/interceptors/oauth_client_credential_interceptor.dart';
import 'package:wandxinc_core/wandxinc_core.dart';

/// RemoteClient is a class that provides the chopper client for making
/// http requests
class RemoteClient {
  /// baseUrl is the base url for the api
  static String baseUrl = WandxincCore.instance.baseUrl;

  /// authHttpClient is the chopper client for making authenticated requests
  static ChopperClient authHttpClient([String? newBaseUrl]) {
    late String url;

    if (newBaseUrl != null) {
      url = newBaseUrl;
    } else {
      url = baseUrl;
    }

    return ChopperClient(
      baseUrl: Uri.parse(url),
      services: WandxincCore.instance.authServices,
      interceptors: <Interceptor>[
        const HeadersInterceptor({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        ..._preAuthInterceptors(),
        ErrorResponseInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) HttpLoggingInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) PrettyChopperLogger(),
        AuthRequestInterceptor(),
        ..._postAuthInterceptors(),
      ],
      converter: const JsonConverter(),
    );
  }

  /// authHttpClient is the chopper client for making authenticated requests
  static ChopperClient oauthClientCredentialHttpClient([String? newBaseUrl]) {
    late String url;

    if (newBaseUrl != null) {
      url = newBaseUrl;
    } else {
      url = baseUrl;
    }

    return ChopperClient(
      baseUrl: Uri.parse(url),
      services: WandxincCore.instance.authServices,
      interceptors: <Interceptor>[
        const HeadersInterceptor({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        ..._preOauthClientInterceptors(),
        ErrorResponseInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) HttpLoggingInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) PrettyChopperLogger(),
        OauthClientCredentialInterceptor(),
        ..._postOauthClientInterceptors(),
      ],
      converter: const JsonConverter(),
    );
  }

  /// httpClient is the chopper client for making requests
  static ChopperClient httpClient([String? newBaseUrl]) {
    late String url;

    if (newBaseUrl != null) {
      url = newBaseUrl;
    } else {
      url = baseUrl;
    }

    return ChopperClient(
      baseUrl: Uri.parse(url),
      services: WandxincCore.instance.services,
      interceptors: <Interceptor>[
        const HeadersInterceptor({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        ..._preInterceptors(),
        ErrorResponseInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) HttpLoggingInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) PrettyChopperLogger(),
        ..._postInterceptors(),
      ],
      converter: const JsonConverter(),
    );
  }
}

List<Interceptor> _preInterceptors() {
  return WandxincCore.instance.interceptors
      .where((e) => e.$1)
      .map((e) => e.$2)
      .toList();
}

List<Interceptor> _postInterceptors() {
  return WandxincCore.instance.interceptors
      .where((e) => !e.$1)
      .map((e) => e.$2)
      .toList();
}

List<Interceptor> _preAuthInterceptors() {
  return WandxincCore.instance.authInterceptors
      .where((e) => e.$1)
      .map((e) => e.$2)
      .toList();
}

List<Interceptor> _postAuthInterceptors() {
  return WandxincCore.instance.authInterceptors
      .where((e) => !e.$1)
      .map((e) => e.$2)
      .toList();
}

List<Interceptor> _preOauthClientInterceptors() {
  return WandxincCore.instance.oauthClientInterceptors
      .where((e) => e.$1)
      .map((e) => e.$2)
      .toList();
}

List<Interceptor> _postOauthClientInterceptors() {
  return WandxincCore.instance.oauthClientInterceptors
      .where((e) => !e.$1)
      .map((e) => e.$2)
      .toList();
}
