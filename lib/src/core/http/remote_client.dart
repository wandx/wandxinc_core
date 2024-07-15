import 'package:chopper/chopper.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';
import 'package:wandxinc_core/src/core/http/interceptors/auth_request_interceptor.dart';
import 'package:wandxinc_core/src/core/http/interceptors/error_response_interceptor.dart';
import 'package:wandxinc_core/wandxinc_core.dart';

/// RemoteClient is a class that provides the chopper client for making
/// http requests
class RemoteClient {
  /// baseUrl is the base url for the api
  static String baseUrl = WandxincCore.instance.baseUrl;

  /// authClient is the chopper client for making authenticated requests
  static ChopperClient get authClient => ChopperClient(
        baseUrl: Uri.parse(baseUrl),
        services: WandxincCore.instance.authServices,
        interceptors: <Interceptor>[
          ErrorResponseInterceptor(),
          HttpLoggingInterceptor(),
          AuthRequestInterceptor(),
          const HeadersInterceptor({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          PrettyChopperLogger(),
          ...WandxincCore.instance.authInterceptors,
        ],
        converter: const JsonConverter(),
      );

  /// client is the chopper client for making requests
  static ChopperClient get client => ChopperClient(
        baseUrl: Uri.parse(baseUrl),
        services: WandxincCore.instance.services,
        interceptors: <Interceptor>[
          ErrorResponseInterceptor(),
          HttpLoggingInterceptor(),
          PrettyChopperLogger(),
          const HeadersInterceptor({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          ...WandxincCore.instance.interceptors,
        ],
        converter: const JsonConverter(),
      );
}
