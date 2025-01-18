import 'package:equatable/equatable.dart';

/// Base class for sorting
class BaseSort extends Equatable {
  /// BaseSort constructor
  const BaseSort({
    required this.key,
    required this.value,
    this.isAscending = true,
  });

  /// The key of the sort
  final String key;

  /// The value of the sort
  final String value;

  /// The order of the sort
  final bool isAscending;

  @override
  List<Object?> get props => [
        key,
        value,
        isAscending,
      ];
}
