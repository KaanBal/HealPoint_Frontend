import 'package:dio/dio.dart'; 
import 'package:yazilim_projesi/services/token_service.dart';

import 'api_client.dart';

class DoctorService {
  final ApiClient apiClient = ApiClient();
  final TokenService tokenService = TokenService();

  Future<Response<dynamic>> fetchAllDoctors() async { 
    try {
      final token = await tokenService.getToken();
      final response = await apiClient.dio.get(
        "doctors/list",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
