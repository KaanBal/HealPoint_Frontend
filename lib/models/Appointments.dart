
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/models/Patients.dart';

enum AppointmentStatus { AKTIF, IPTAL, TAMAMLANDI}

class Appointments {
  final int Appointment_id;
  final DateTime Appointment_date;
  final String appointment_time;
  final AppointmentStatus Appointment_status;
  final String? Appointment_text;
  final Patients patient;
  final Doctors doctor;

  Appointments({
    required this.Appointment_id,
    required this.Appointment_date,
    required this.appointment_time,
    required this.Appointment_status,
    this.Appointment_text,
    required this.patient,
    required this.doctor,
  });

  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
      Appointment_id: json['appointmentId'],
      Appointment_date: DateTime.parse(json['appointmentDate']),
      appointment_time: json['appointmentTime'],
      Appointment_status: AppointmentStatus.values.firstWhere((e) =>
          e.toString() == 'AppointmentStatus.${json['appointmentStatus']}'),
      Appointment_text: json['appointmentText'],
      patient: Patients.fromJson(json['patient']),
      doctor: Doctors.fromJson(json['doctor']),
    );
  }
}
