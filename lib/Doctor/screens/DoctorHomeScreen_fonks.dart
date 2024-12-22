import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/services/appointments_service.dart';

class DoctorHomeScreenFonks {
  final AppointmentsService appointmentsService = AppointmentsService();

Future<List<Appointments>> fetchAppointments() async {
  try {
    final response = await appointmentsService.fetchAppointmentsByDoctor();
    final List<dynamic> data = response.data;

    return data.map((appointmentJson) => Appointments.fromJson(appointmentJson)).toList();
  } catch (e) {
    print("Hata oluştu: $e");
    return [];
  }
}

}
  