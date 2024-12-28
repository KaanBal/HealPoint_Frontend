import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/models/filterValues.dart';
import 'package:yazilim_projesi/services/api_client.dart';
import 'package:yazilim_projesi/services/token_service.dart';

class DoctorService {
  final ApiClient apiClient = ApiClient();
  final TokenService tokenService = TokenService();

  Future<Response> fetchAllDoctors() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      print(token);
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

  Future<Response> getDoctorAvailabilities(String id, DateTime date) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final formattedDate = DateFormat('yyyy-MM-dd').format(date);

      final response = await apiClient.dio.get(
        "doctor/availability/times/$id",
        queryParameters: {
          "date": formattedDate,
        },
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

  Future<Response> saveDoctorAvailability(
      Map<String, dynamic> availabilityData) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.post(
        "doctor/availability/save",
        data: availabilityData,
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

  Future<Response> updateDoctorAvailability(
      String id, Map<String, dynamic> availabilityData) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.put(
        "doctor/availability/update/$id",
        data: availabilityData,
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

  Future<Response> getDoctorById(String id) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "doctors/list/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> getDoctorByToken() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "doctors/list-token",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> deleteDoctorById(String id) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.delete(
        "doctors/delete/$id",
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

  Future<Response> saveDoctor(Map<String, dynamic> doctorData) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.post(
        "doctors/save",
        data: doctorData,
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

  Future<Response> updateDoctorById(Doctors doctorData) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.put(
        "doctors/update",
        data: doctorData,
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

  Future<Response> addFavoriteDoctor(String doctorTc) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.post(
        "favorites/add/$doctorTc",
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

  Future<Response> getFavoriteDoctors() async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.get(
        "favorites/list",
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

  Future<Response> removeFavoriteDoctor(String doctorTc) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.delete(
        "favorites/remove/$doctorTc",
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

  Future<Response> filterDoctors(FilterValues filterValues) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token not found. Please log in again.");
      }

      final formattedDate = filterValues.date != null
          ? DateFormat('yyyy-MM-dd').format(filterValues.date!)
          : null;

      final timeOfDayClock = stringToTimeOfDay(filterValues.time!);

      final formattedTime = filterValues.time != null
          ? "${timeOfDayClock.hour.toString().padLeft(2, '0')}:${timeOfDayClock.minute.toString().padLeft(2, '0')}"
          : null;
      final response = await apiClient.dio.get(
        "doctors/filter",
        queryParameters: {
          if (filterValues.city != null) "city": filterValues.city,
          if (filterValues.district != null) "district": filterValues.district,
          if (filterValues.branch != null) "branch": filterValues.branch,
          if (formattedDate != null) "appointmentDate": formattedDate,
          if (formattedTime != null) "appointmentTime": formattedTime,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } catch (e) {
      throw Exception("Error occurred while filtering doctors: $e");
    }
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    final format = timeString.split(":");
    final hour = int.parse(format[0]);
    final minute = int.parse(format[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
