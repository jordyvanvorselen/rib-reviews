import 'package:envify/envify.dart';

part 'env.g.dart';

@Envify()
abstract class Env {
  static var apiKey = _Env.apiKey;
  static var apiUrl = _Env.localhost;
  static var localhost = _Env.localhost;

  static Uri apiPath(String path) {
    return _Env.localhost == 'true'
        ? Uri.http(_Env.apiUrl, '/api$path')
        : Uri.https(_Env.apiUrl, '/api$path');
  }
}
