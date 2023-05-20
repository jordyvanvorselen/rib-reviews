import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

class API {
  FlutterSecureStorage storage;
  // http.Client client;
  Dio client;
  API({required this.storage, required this.client});

  TaskEither<String, Response> get(String resource) {
    return TaskEither.tryCatch(() async {
      final idToken = await storage.read(key: 'idToken') ?? '';

      final response = await client.get(resource,
          options: Options(headers: {"Authorization": idToken}));

      if (response.statusCode != 200) {
        throw response.data;
      }

      return response;
    }, (error, stackTrace) {
      return error.toString();
    });
  }

  TaskEither<String, Response> post(String resource, Object body) {
    return TaskEither.tryCatch(() async {
      final idToken = await storage.read(key: 'idToken') ?? '';

      final response = await client.post(resource,
          data: body,
          options: Options(
            headers: {
              "Authorization": idToken,
              "Content-Type": "application/json"
            },
          ));

      if (response.statusCode != 200) {
        throw response.data;
      }

      return response;
    }, (error, stackTrace) {
      return error.toString();
    });
  }
}
