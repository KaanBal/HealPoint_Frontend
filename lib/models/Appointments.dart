import 'package:flutter/material.dart';
import 'package:yazilim_projesi/models/DoctorReview.dart';
import 'package:yazilim_projesi/models/PatientReview.dart';

enum AppointmentStatus { AKTIF, IPTAL, TAMAMLANDI }

class Appointments {
  final DateTime? appointmentDate;
  final TimeOfDay? appointmentTime; // TimeOfDay ile tanımlama
  final AppointmentStatus? appointmentStatus;
  final String? appointmentText;
  final DoctorReview? doctor;
  final PatientReview? patient;

  Appointments({
    this.appointmentDate,
    this.appointmentTime,
    this.appointmentStatus,
    this.appointmentText,
    this.doctor,
    this.patient,
  });

  factory Appointments.fromJson(Map<String, dynamic> json) {
    // Gelen JSON'u debug için kontrol edin
    print("Doctor Review JSON: ${json['doctorReview']}");

    final timeParts = json['appointmentTime']?.split(':');
    final timeOfDay = timeParts != null && timeParts.length >= 2
        ? TimeOfDay(
            hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]))
        : null;

    return Appointments(
      appointmentDate: json['appointmentDate'] != null
          ? DateTime.parse(json['appointmentDate'])
          : null,
      appointmentTime: timeOfDay,
      appointmentStatus: AppointmentStatus.values.firstWhere((e) =>
          e.toString() == 'AppointmentStatus.${json['appointmentStatus']}'),
      appointmentText: json['appointmentText'],
      doctor: json['doctor'] != null
          ? DoctorReview.fromJson(
              json['doctor']) 
          : null,
      patient: json['patient'] != null
          ? PatientReview.fromJson(json['patient'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentDate': appointmentDate?.toIso8601String(),
      'appointmentTime': appointmentTime != null
          ? '${appointmentTime!.hour.toString().padLeft(2, '0')}:${appointmentTime!.minute.toString().padLeft(2, '0')}'
          : null,
      'appointmentStatus': appointmentStatus?.toString().split('.').last,
      'appointmentText': appointmentText,
      'doctorReview': doctor?.toJson(),
      'patient': patient?.toJson(),
    };
  }
}
