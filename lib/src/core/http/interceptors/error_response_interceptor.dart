import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:wandxinc_core/src/wandxinc_core.dart';

/// ErrorResponseInterceptor is an interceptor that handles error responses
class ErrorResponseInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    try {
      final response = await chain.proceed(chain.request);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        final messages = <String>[];
        late Map<String, dynamic> body;
        var code = 0;

        if (response.body == null) {
          body = jsonDecode(response.bodyString) as Map<String, dynamic>;
        } else {
          body = response.body! as Map<String, dynamic>;
        }

        if (body.containsKey('code')) {
          code = body['code'] as int;
        }

        try {
          final message = <String>[];
          if (body.containsKey('errors')) {
            final errors = body['errors'] as List<dynamic>;
            if (errors.isEmpty) {
              throw Exception('No error message found');
            }
            (body['errors'] as Map<String, dynamic>).forEach((k, dynamic v) {
              for (final msg in v as List) {
                message.add('$msg');
                // message.add('$k : $msg');
              }
            });
            messages.add(message.first);
          } else {
            throw Exception('No error message found');
          }
        } on Exception catch (_) {
          if (body.containsKey('message')) {
            messages.add(body['message'] as String);
          }

          if (body.containsKey('Message')) {
            messages.add(body['Message'] as String);
          }

          if (body.containsKey('response_message')) {
            messages.add(body['response_message'] as String);
          }

          for (final key in WandxincCore.instance.errorMessageKeys) {
            if (body.containsKey(key)) {
              messages.add(body[key] as String);
            }
          }
        } finally {
          messages.add('Error Occured');
        }

        messages.add('No Data');
        throw ResponseException(
          message: messages.first,
          httpCode: response.statusCode,
          code: code,
        );
      }
      return response;
    } on SocketException catch (_) {
      throw ResponseException(
        message: 'Tidak ada koneksi internet',
        code: 1110,
        httpCode: 500,
      );
    } on HandshakeException catch (_) {
      throw ResponseException(
        message: 'Tidak ada koneksi internet',
        code: 1110,
        httpCode: 500,
      );
    } on TimeoutException catch (_) {
      throw ResponseException(
        message: 'Timeout',
        code: 1111,
        httpCode: 500,
      );
    } catch (e) {
      throw ResponseException(
        message: e.toString(),
        code: 1199,
        httpCode: 500,
      );
    }
  }
}

/// ResponseException is an exception that is thrown when a response is not successful
class ResponseException implements Exception {
  /// Constructor for the ResponseException class
  ResponseException({
    required this.message,
    this.code = 0,
    this.httpCode = 200,
  });

  /// The message of the exception
  final String message;

  /// The code of the exception
  final int code;

  /// The http code of the exception
  final int httpCode;

  @override
  String toString() {
    return message;
  }
}
