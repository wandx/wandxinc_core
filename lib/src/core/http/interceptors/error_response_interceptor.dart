import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

class ErrorResponseInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response<dynamic>> onResponse(Response<dynamic> response) {
    // if (response.statusCode == 401) {
    //   final context = getIt<GlobalKey<NavigatorState>>(
    //           instanceName: AppEnvironment.navigatorKey)
    //       .currentContext;
    //   if (context != null) {
    //     Navigator.popUntil(context, (route) => route.isFirst);
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute<void>(
    //         builder: (context) => const OnBoardingScreen(),
    //       ),
    //     );
    //   }
    print(response.bodyString);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final messages = <String>[];
      late Map<String, dynamic> body;

      if (response.body == null) {
        body = jsonDecode(response.bodyString) as Map<String, dynamic>;
      } else {
        body = response.body as Map<String, dynamic>;
      }

      try {
        final message = <String>[];
        (body['errors'] as Map<String, dynamic>).forEach((k, dynamic v) {
          for (final msg in v as List) {
            message.add('$msg');
            // message.add('$k : $msg');
          }
        });

        messages.add(message.first);
      } catch (error) {
        messages.add(body['message'] as String);
      } finally {
        messages.add('Error Occured');
      }

      messages.add('No Data');
      throw _ResponseException(messages.first);
    }
    return response;
  }
}

class _ResponseException implements Exception {
  _ResponseException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
