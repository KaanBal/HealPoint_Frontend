import 'package:yazilim_projesi/models/DoctorReview.dart';
import 'package:yazilim_projesi/models/Patients.dart';

enum AppointmentStatus { AKTIF, IPTAL, TAMAMLANDI }

class Appointments {
  final DateTime? appointmentDate;
  final String? appointmentTime;
  final AppointmentStatus? appointmentStatus;
  final String? appointmentText;
  final DoctorReview? doctorReview;
  final Patients? patient;

  Appointments({
    this.appointmentDate,
    this.appointmentTime,
    this.appointmentStatus,
    this.appointmentText,
    this.doctorReview,
    this.patient,
  });

  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
        appointmentDate: DateTime.parse(json['appointmentDate']),
        appointmentTime: json['appointmentTime'],
        appointmentStatus: AppointmentStatus.values.firstWhere((e) =>
            e.toString() == 'AppointmentStatus.${json['appointmentStatus']}'),
        appointmentText: json['appointmentText'],
        doctorReview: json['doctorReview'] != null
            ? DoctorReview.fromJson(json['doctorReview'])
            : null,
        patient: json['patient'] != null
            ? Patients.fromJson(json['patient'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'appointmentStatus': appointmentStatus,
      'appointmentText': appointmentText,
      'doctorReview': doctorReview,
      'patient': patient
    };
  }
}
