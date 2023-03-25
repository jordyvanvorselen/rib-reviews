import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageProvider with ChangeNotifier {
  final storage = const FlutterSecureStorage();
}
