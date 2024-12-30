import 'dart:ffi';

import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/services/appointments_service.dart';

class YaklasanRandevularFonks {
  AppointmentsService appointmentsService = AppointmentsService();

  Future<void> cancelAppointment(int id) async {
    try {
      await appointmentsService.cancelAppointment(id);
    } catch (e) {
      print(e);
    }
  }
}
