import 'package:dio/dio.dart';
import 'package:yazilim_projesi/models/Patients.dart';
import 'package:yazilim_projesi/services/api_client.dart';
import 'package:yazilim_projesi/services/token_service.dart';

class PatientService {
  final ApiClient apiClient = ApiClient();
  final TokenService tokenService = TokenService();

  Future<Response> createPatient(Map<String, dynamic> patientData) async {
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

  Future<Response> getPatientName() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "patients/name",
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

  Future<Response> updatePatient(Patients patientData) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.put(
        "patients/update",
        data: patientData.toJson(),
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

  Future<Response> getPatientById() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "patients/list",
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
