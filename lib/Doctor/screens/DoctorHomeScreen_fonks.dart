import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/services/appointments_service.dart';
import 'package:yazilim_projesi/services/doctor_service.dart';

class DoctorHomeScreenFonks {
  final AppointmentsService appointmentsService = AppointmentsService();
  final DoctorService doctorService = DoctorService();

  Future<List<Appointments>> fetchAppointments() async {
    try {
      final response = await appointmentsService.fetchAppointmentsByDoctor();
      final List<dynamic> data = response.data;

      return data
          .map((appointmentJson) => Appointments.fromJson(appointmentJson))
          .toList();
    } catch (e) {
      print("Hata oluştu: $e");
      return [];
    }
  }

  Future<Doctors?> loadData() async {
    try {
      final response = await doctorService.getDoctorByToken();
      final Map<String, dynamic> data = response.data;
      return Doctors.fromJson(data);
    } catch (e) {
      print("Hata oluştu: $e");
      return null;
    }
  }

  Future<void> cancelAppointment(int id) async {
    try {
      await appointmentsService.cancelAppointmentForDoctor(id);
    } catch (e) {
      print(e);
    }
  }
}
