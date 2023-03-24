import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField()
  static const API_URL = _Env.API_URL;
  @EnviedField()
  static const LOCALHOST = _Env.LOCALHOST;

  static Uri apiPath(String path) {
    return _Env.LOCALHOST == 'true'
        ? Uri.http(_Env.API_URL, '/api$path')
        : Uri.https(_Env.API_URL, '/api$path');
  }
}
