import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yazilim_projesi/services/api_client.dart';

class AuthService {
  final ApiClient apiClient = ApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Response> patientSignUp(Map<String, dynamic> patientData) async {
    try {
      final response = await apiClient.dio.post(
        "patients/save", 
        data: patientData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data["token"];
        if (token != null) {
          await _storage.write(key: "auth_token", value: token);
        }
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
