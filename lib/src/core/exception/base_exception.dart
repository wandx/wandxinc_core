/// Base exception class for all exceptions in the application.
abstract class BaseException implements Exception {
  /// Constructor for the base exception class.
  BaseException({required this.message});

  /// The error message.
  final String message;

  @override
  String toString() => message;
}
