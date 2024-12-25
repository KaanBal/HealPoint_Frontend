import 'dart:convert';

import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/models/Reviews.dart';
import 'package:yazilim_projesi/services/appointments_service.dart';
import 'package:yazilim_projesi/services/review_service.dart';

class HastaYorumFonks {
  final AppointmentsService appointmentsService = AppointmentsService();
  final ReviewService reviewService = ReviewService();

  Future<Appointments?> getAppointmentDetails() async {
    try {
      final response = await appointmentsService.fetchAppointmentsByPatient();

      if (response.statusCode == 200) {
        final List<dynamic> appointmentsJson = json.decode(response.data);
        final List<Appointments> appointments = appointmentsJson
            .map((appointment) => Appointments.fromJson(appointment))
            .toList();

        if (appointments.isNotEmpty) {
          return appointments.last;
        } else {
          return null;
        }
      } else {
        throw Exception("Failed to fetch appointments: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching appointments: $e");
      rethrow;
    }
  }

  Future<void> createReview(Reviews review) async {
    try {
      final reviewData = review.toJson();
      final response = await reviewService.createReview(reviewData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Kayıt başarılı: ${response.data}");
      } else {
        print("Kayıt başarısız: ${response.statusMessage}");
      }
    } catch (e) {
      print("Hata oluştu: $e");
      rethrow;
    }
  }
}

