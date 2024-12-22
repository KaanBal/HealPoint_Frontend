import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/services/appointments_service.dart';

class GecmisRandevuFonks {
  final AppointmentsService appointmentsService = AppointmentsService();

  Future<List<Appointments>> fetchPastAppointments() async {
    try {
      final response =
          await appointmentsService.fetchCompletedAndCancelledAppointments();
      final List<dynamic> data = response.data;

      return data
          .map((appointmentJson) => Appointments.fromJson(appointmentJson))
          .toList();
    } catch (e) {
      print("Hata oluştu: $e");
      return [];
    }
  }

  String statusToText(AppointmentStatus? status) {
    switch (status) {
      case AppointmentStatus.IPTAL:
        return "İptal Edildi";
      case AppointmentStatus.TAMAMLANDI:
        return "Tamamlandı";
      default:
        return "Bilinmiyor";
    }
  }

  Color statusColor(AppointmentStatus? status) {
    switch (status) {
      case AppointmentStatus.IPTAL:
        return Colors.red;
      case AppointmentStatus.TAMAMLANDI:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
