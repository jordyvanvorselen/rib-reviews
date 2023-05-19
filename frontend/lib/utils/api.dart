import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class API {
  FlutterSecureStorage storage;
  http.Client client;
  API({required this.storage, required this.client});

  TaskEither<String, http.Response> get(Uri url) {
    return TaskEither.tryCatch(() async {
      final idToken = await storage.read(key: 'idToken') ?? '';

      final response =
          await client.get(url, headers: {"Authorization": idToken});

      if (response.statusCode != 200) {
        throw response.body;
      }

      return response;
    }, (error, stackTrace) {
      return error.toString();
    });
  }

  TaskEither<String, http.Response> post(Uri url, Object body) {
    final client = http.Client();

    return TaskEither.tryCatch(() async {
      final idToken = await storage.read(key: 'idToken') ?? '';

      final response = await client.post(url, body: body, headers: {
        "Authorization": idToken,
        "Content-Type": "application/json"
      });

      if (response.statusCode != 200) {
        throw response.body;
      }

      return response;
    }, (error, stackTrace) {
      return error.toString();
    });
  }
}
