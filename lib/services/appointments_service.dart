import 'package:dio/dio.dart';
import 'package:yazilim_projesi/services/api_client.dart';
import 'package:yazilim_projesi/services/token_service.dart';

class AppointmentsService {
  final TokenService tokenService = TokenService();
  final ApiClient apiClient = ApiClient();

  Future<Response> fetchUpcomingAppointments() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "appointments/list/patient/active-appointments",
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

  Future<Response> createAppointment(Map<String, dynamic> appointmentData) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.post(
        "appointments/create",
        data: appointmentData,
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

  Future<Response> fetchCompletedAndCancelledAppointments() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "appointments/completed-and-cancelled",
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

  Future<Response> fetchAppointmentsByPatient() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "appointments/list/patient/active-appointments",
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

  Future<Response> fetchAppointmentsByDoctor() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "appointments/list/doctor/active-appointments",
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

  Future<Response> fetchPastAppointmentsByDoctor() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "appointments/list/doctor/completed-cancelled",
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
