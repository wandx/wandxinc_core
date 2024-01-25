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
        interceptors: <dynamic>[
          ErrorResponseInterceptor(),
          HttpLoggingInterceptor(),
          AuthRequestInterceptor(),
          const HeadersInterceptor({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          PrettyChopperLogger(),
          ...WandxincCore.instance.authRequestInterceptors,
          ...WandxincCore.instance.authResponseInterceptors,
        ],
        converter: const JsonConverter(),
      );

  static ChopperClient get client => ChopperClient(
        baseUrl: Uri.parse(baseUrl),
        services: WandxincCore.instance.services,
        interceptors: <dynamic>[
          ErrorResponseInterceptor(),
          HttpLoggingInterceptor(),
          PrettyChopperLogger(),
          const HeadersInterceptor({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          ...WandxincCore.instance.requestInterceptors,
          ...WandxincCore.instance.responseInterceptors,
        ],
        converter: const JsonConverter(),
      );
}
