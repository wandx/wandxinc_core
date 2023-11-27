// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:wandxinc_core/wandxinc_core.dart';

void main() {
  group('WandxincCore', () {
    test('can be instantiated', () {
      expect(WandxincCore.instance, isNotNull);
    });
  });
}
