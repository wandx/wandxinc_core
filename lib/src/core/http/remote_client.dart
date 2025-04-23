import 'package:chopper/chopper.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';
import 'package:wandxinc_core/src/core/http/interceptors/oauth_client_credential_interceptor.dart';
import 'package:wandxinc_core/wandxinc_core.dart';

/// RemoteClient is a class that provides the chopper client for making
/// http requests
class RemoteClient {
  /// baseUrl is the base url for the api
  static String baseUrl = WandxincCore.instance.baseUrl;

  /// authClient is the chopper client for making authenticated requests
  @Deprecated('Use authHttpClient instead')
  static ChopperClient get authClient => ChopperClient(
        baseUrl: Uri.parse(baseUrl),
        services: WandxincCore.instance.authServices,
        interceptors: <Interceptor>[
          ErrorResponseInterceptor(),
          if (WandxincCore.instance.enableHttpLogging) HttpLoggingInterceptor(),
          if (WandxincCore.instance.enableHttpLogging) PrettyChopperLogger(),
          AuthRequestInterceptor(),
          const HeadersInterceptor({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          ...WandxincCore.instance.authInterceptors,
        ],
        converter: const JsonConverter(),
      );

  /// client is the chopper client for making requests
  @Deprecated('Use httpClient instead')
  static ChopperClient get client => ChopperClient(
        baseUrl: Uri.parse(baseUrl),
        services: WandxincCore.instance.services,
        interceptors: <Interceptor>[
          ErrorResponseInterceptor(),
          if (WandxincCore.instance.enableHttpLogging) HttpLoggingInterceptor(),
          if (WandxincCore.instance.enableHttpLogging) PrettyChopperLogger(),
          const HeadersInterceptor({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          ...WandxincCore.instance.interceptors,
        ],
        converter: const JsonConverter(),
      );

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
        ErrorResponseInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) HttpLoggingInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) PrettyChopperLogger(),
        AuthRequestInterceptor(),
        const HeadersInterceptor({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        ...WandxincCore.instance.authInterceptors,
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
        ErrorResponseInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) HttpLoggingInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) PrettyChopperLogger(),
        OauthClientCredentialInterceptor(),
        const HeadersInterceptor({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        ...WandxincCore.instance.oauthClientInterceptors,
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
        ErrorResponseInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) HttpLoggingInterceptor(),
        if (WandxincCore.instance.enableHttpLogging) PrettyChopperLogger(),
        const HeadersInterceptor({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        ...WandxincCore.instance.interceptors,
      ],
      converter: const JsonConverter(),
    );
  }
}
