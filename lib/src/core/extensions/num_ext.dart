import 'package:intl/intl.dart';

/// Extension on num to format currency
extension NumExt on num {
  /// Format the number to currency
  String currency({
    String? prefix,
    String? locale,
  }) {
    final n = NumberFormat('#,###', locale);

    if (prefix != null) {
      return '$prefix ${n.format(this)}';
    }
    return n.format(this);
  }
}
