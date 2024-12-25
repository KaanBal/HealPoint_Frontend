import 'package:flutter/material.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/models/Patients.dart';

enum AppointmentStatus { AKTIF, IPTAL, TAMAMLANDI }

class Appointments {
  final DateTime? appointmentDate;
  final TimeOfDay? appointmentTime; // TimeOfDay ile tanımlama
  final AppointmentStatus? appointmentStatus;
  final String? appointmentText;
  final Doctors? doctor;
  final Patients? patient;
  final String? status;

  Appointments({
    this.appointmentDate,
    this.appointmentTime,
    this.appointmentStatus,
    this.appointmentText,
    this.doctor,
    this.patient,
    this.status,
  });

  Color getStatusColor() {
    if (status == "AKTIF") {
      return Colors.green;
    } else if (status == "IPTAL") {
      return Colors.red;
    } else if (status == null) {
      return Colors.grey;
    } else {
      return Colors.blue;
    }
  }

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
      doctor:
          json['doctor'] != null ? Doctors.fromJson(json['doctor']) : null,
      patient: json['patient'] != null
          ? Patients.fromJson(json['patient'])
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
