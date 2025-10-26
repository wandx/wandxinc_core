import 'package:wandxinc_core/src/core/abstracts/serializable.dart';

abstract class SerializableFactory {
  Serializable fromJson(Map<String, dynamic> json);
}
