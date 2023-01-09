import 'package:http/http.dart' as http;
import 'package:rib_reviews/env/env.dart';

class API {
  static Future<String> get(Uri url) {
    final client = http.Client();

    try {
      return client.read(url, headers: {"Authorization": Env.apiKey});
    } finally {
      client.close();
    }
  }

  static Future<String> post(Uri url, Object body) async {
    final client = http.Client();

    try {
      http.Response response = await client.post(url, body: body, headers: {
        "Authorization": Env.apiKey,
        "Content-Type": "application/json"
      });

      return response.body;
    } finally {
      client.close();
    }
  }
}
