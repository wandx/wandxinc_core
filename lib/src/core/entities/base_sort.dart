import 'package:equatable/equatable.dart';

class BaseSort extends Equatable {
  const BaseSort({
    required this.key,
    required this.value,
    this.isAscending = true,
  });

  final String key;
  final String value;
  final bool isAscending;

  @override
  List<Object?> get props => [
        key,
        value,
        isAscending,
      ];
}
