import 'package:yazilim_projesi/models/Reviews.dart';
import 'package:yazilim_projesi/services/review_service.dart';

class DoktorYorumFonks {
  final ReviewService reviewService = ReviewService();

  Future<List<Reviews>> fetchComments() async {
    try {
      final response = await reviewService.getDoctorReviews();
      final List<dynamic> data = response.data;

      return data
          .map((json) => Reviews.fromJson(json))
          .toList();
    } catch (e) {
      print("Hata oluştu: $e");
      return [];
    }
  }
  
}
