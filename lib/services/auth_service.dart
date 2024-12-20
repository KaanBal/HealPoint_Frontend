import 'package:dio/dio.dart';
import 'package:yazilim_projesi/services/api_client.dart';
import 'package:yazilim_projesi/services/token_service.dart';

class AuthService {
  final ApiClient apiClient = ApiClient();
  final TokenService tokenService = TokenService();

  Future<Response> patientSignUp(Map<String, dynamic> patientData) async {
    try {
      final response = await apiClient.dio.post(
        "patients/create",
        data: patientData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patientSignIn(String username, String password) async {
    try {
      final response = await apiClient.dio.post(
        "login",
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data["token"];
        if (token != null) {
          tokenService.writeToken(token);
        }
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
