import 'package:envify/envify.dart';

part 'env.g.dart';

@Envify()
abstract class Env {
  static var apiKey = _Env.apiKey;
  static var apiUrl = (String path) => _Env.localhost == 'true'
      ? Uri.http(_Env.apiUrl, '/api$path')
      : Uri.https(_Env.apiUrl, '/api$path');
  static var localhost = _Env.localhost;
}
