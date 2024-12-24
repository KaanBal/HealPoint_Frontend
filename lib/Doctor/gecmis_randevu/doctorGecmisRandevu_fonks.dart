import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/services/appointments_service.dart';

class DoctorGecmisRandevuFonks {
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
}
