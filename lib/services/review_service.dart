import 'package:dio/dio.dart';
import 'package:yazilim_projesi/services/api_client.dart';
import 'package:yazilim_projesi/services/token_service.dart';

class ReviewService {
  final ApiClient apiClient = ApiClient();
  final TokenService tokenService = TokenService();

  Future<Response> createReview(Map<String, dynamic> reviewData) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        throw Exception("Token bulunamadı. Lütfen tekrar giriş yapın.");
      }

      final response = await apiClient.dio.post(
        "review/create",
        data: reviewData,
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
