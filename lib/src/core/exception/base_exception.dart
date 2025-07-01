/// Base exception class for all exceptions in the application.
abstract class BaseException implements Exception {
  /// Constructor for the base exception class.
  BaseException({
    required this.message,
    this.code = 0,
  });

  /// The error message.
  final String message;

  /// The error code.
  final int code;

  @override
  String toString() => message;
}
