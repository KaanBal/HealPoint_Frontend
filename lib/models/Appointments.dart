
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

  // JSON'dan nesneye dönüştürme
  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
      Appointment_id: json['Appointment_id'],
      Appointment_date: DateTime.parse(json['Appointment_date']),
      appointment_time: json['appointment_time'],
      Appointment_status: AppointmentStatus.values.firstWhere((e) =>
          e.toString() == 'AppointmentStatus.${json['Appointment_status']}'),
      Appointment_text: json['Appointment_text'],
      patient: Patients.fromJson(json['patient']),
      doctor: Doctors.fromJson(json['doctor']),
    );
  }
}
