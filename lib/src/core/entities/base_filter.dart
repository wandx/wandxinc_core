import 'package:equatable/equatable.dart';

class BaseFilter extends Equatable {
  const BaseFilter({
    required this.key,
    required this.value,
    this.operator = '=',
  });

  final String key;
  final String value;
  final String operator;

  @override
  List<Object?> get props => [
        key,
        value,
        operator,
      ];
}
