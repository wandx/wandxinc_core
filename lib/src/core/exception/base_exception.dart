abstract class BaseException implements Exception {
  BaseException({required this.message});

  final String message;

  @override
  String toString() => message;
}
