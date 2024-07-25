import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

/// ErrorResponseInterceptor is an interceptor that handles error responses
class ErrorResponseInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final response = await chain.proceed(chain.request);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final messages = <String>[];
      late Map<String, dynamic> body;

      if (response.body == null) {
        body = jsonDecode(response.bodyString) as Map<String, dynamic>;
      } else {
        body = response.body! as Map<String, dynamic>;
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
        if (body.containsKey('message')) {
          messages.add(body['message'] as String);
        }

        if (body.containsKey('Message')) {
          messages.add(body['Message'] as String);
        }

        if (body.containsKey('response_message')) {
          messages.add(body['response_message'] as String);
        }
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
