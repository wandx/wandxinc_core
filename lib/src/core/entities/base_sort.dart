import 'package:equatable/equatable.dart';

/// Base class for sorting
class BaseSort extends Equatable {
  /// BaseSort constructor
  const BaseSort({
    required this.key,
    this.isAscending = true,
  });

  /// The key of the sort
  final String key;

  /// The order of the sort
  final bool isAscending;

  @override
  List<Object?> get props => [
        key,
        isAscending,
      ];
}
