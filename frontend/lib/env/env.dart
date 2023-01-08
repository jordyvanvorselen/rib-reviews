import 'package:envify/envify.dart';

part 'env.g.dart';

@Envify()
abstract class Env {
  static var apiKey = _Env.apiKey;
  static var apiUrl = _Env.apiUrl;
}
