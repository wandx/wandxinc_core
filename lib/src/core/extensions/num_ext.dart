import 'package:intl/intl.dart';

extension NumExt on num {
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
