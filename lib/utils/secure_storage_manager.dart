import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum StoreKeyType {
  access_token,
}

class SecureStorageController {
  static const _storage = FlutterSecureStorage();

  static Future write(String key, String value) async => await _storage.write(key: key, value: value);

  static Future writeWithKey(StoreKeyType keyType, String value) async =>
      await _storage.write(key: keyType.name, value: value);

  static Future<String?> read(String key) async => await _storage.read(key: key);

  static Future<String?> readWithKey(StoreKeyType keyType) async => await _storage.read(key: keyType.name);
}
