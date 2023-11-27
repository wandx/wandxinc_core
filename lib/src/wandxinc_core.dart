import 'package:chopper/chopper.dart';

/// {@template wandxinc_core}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WandxincCore {
  WandxincCore._();

  static WandxincCore instance = WandxincCore._();

  String baseUrl = '';

  List<ChopperService> services = [];

  List<ChopperService> authServices = [];
}
