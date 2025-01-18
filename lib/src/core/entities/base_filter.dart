import 'package:equatable/equatable.dart';

/// Base class for filters
class BaseFilter extends Equatable {
  /// BaseFilter constructor
  const BaseFilter({
    required this.key,
    required this.value,
    this.operator = '=',
  });

  /// The key of the filter
  final String key;

  /// The value of the filter
  final String value;

  /// The operator of the filter
  final String operator;

  @override
  List<Object?> get props => [
        key,
        value,
        operator,
      ];
}
