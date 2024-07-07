import 'package:chopper/chopper.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';
import 'package:wandxinc_core/src/core/http/interceptors/auth_request_interceptor.dart';
import 'package:wandxinc_core/src/core/http/interceptors/error_response_interceptor.dart';
import 'package:wandxinc_core/wandxinc_core.dart';

class RemoteClient {
  static String baseUrl = WandxincCore.instance.baseUrl;

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
