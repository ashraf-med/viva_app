import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class tokenStorage {
  static final _storage = FlutterSecureStorage();
  static Future  setToken(String token) async =>
       await _storage.write(key: 'token', value: token);

  static Future<String?>  getToken() async =>
      await _storage.read(key: 'token');
  static Future delteToken() async=>
      await _storage.delete(key: 'token');
}
