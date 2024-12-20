import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return await _storage.read(key: "auth_token");
  }

  Future writeToken(String token) async {
    await _storage.write(key: "auth_token", value: token);
  }
}
