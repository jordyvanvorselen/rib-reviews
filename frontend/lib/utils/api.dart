import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class API {
  FlutterSecureStorage storage;

  API({required this.storage});

  Future<String> get(Uri url) async {
    final client = http.Client();

    try {
      final idToken = await storage.read(key: 'idToken') ?? '';

      return await client.read(url, headers: {"Authorization": idToken});
    } finally {
      client.close();
    }
  }

  Future<String> post(Uri url, Object body) async {
    final client = http.Client();

    try {
      final idToken = await storage.read(key: 'idToken') ?? '';

      http.Response response = await client.post(url, body: body, headers: {
        "Authorization": idToken,
        "Content-Type": "application/json"
      });

      return response.body;
    } finally {
      client.close();
    }
  }
}
