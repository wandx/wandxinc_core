import 'package:chopper/chopper.dart';
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
        ],
        converter: const JsonConverter(),
      );

  static ChopperClient get client => ChopperClient(
        baseUrl: Uri.parse(baseUrl),
        services: WandxincCore.instance.services,
        interceptors: <dynamic>[
          ErrorResponseInterceptor(),
          HttpLoggingInterceptor(),
          const HeadersInterceptor({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
        ],
        converter: const JsonConverter(),
      );
}
