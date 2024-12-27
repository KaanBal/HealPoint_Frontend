import 'package:flutter/material.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/models/Patients.dart';

enum AppointmentStatus { AKTIF, IPTAL, TAMAMLANDI }

class Appointments {
  final int? appointmentId; 
  final DateTime? appointmentDate;
  final TimeOfDay? appointmentTime;
  final AppointmentStatus appointmentStatus;
  final String? appointmentText;
  final Doctors? doctor;
  final String? doctorTc;
  final Patients? patient;
  final String? patientTc;
  final String? status;

  Appointments({
    this.appointmentId,
    this.appointmentDate,
    this.appointmentTime,
    this.appointmentText,
    this.doctor,
    this.doctorTc,
    this.patient,
    this.patientTc,
    this.status,
    this.appointmentStatus = AppointmentStatus.AKTIF,
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
    print("Doctor Review JSON: ${json['doctorReview']}");

    final timeParts = json['appointmentTime']?.split(':');
    final timeOfDay = timeParts != null && timeParts.length >= 2
        ? TimeOfDay(
            hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]))
        : null;

    return Appointments(
      appointmentId: json['appointmentId'],
      appointmentDate: json['appointmentDate'] != null
          ? DateTime.parse(json['appointmentDate'])
          : null,
      appointmentTime: timeOfDay,
      appointmentStatus: AppointmentStatus.values.firstWhere(
        (e) => e.toString() == 'AppointmentStatus.${json['appointmentStatus']}',
        orElse: () => AppointmentStatus.AKTIF,
      ),
      appointmentText: json['appointmentText'],
      doctor: json['doctor'] != null ? Doctors.fromJson(json['doctor']) : null,
      doctorTc: json['doctorTc'],
      patient:
          json['patient'] != null ? Patients.fromJson(json['patient']) : null,
      patientTc: json['patientTc'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId, // JSON'a `int` olarak eklenir
      'appointmentDate': appointmentDate?.toIso8601String().split('T').first,
      'appointmentTime': appointmentTime != null
          ? '${appointmentTime!.hour.toString().padLeft(2, '0')}:${appointmentTime!.minute.toString().padLeft(2, '0')}'
          : null,
      'appointmentStatus': appointmentStatus.toString().split('.').last,
      'appointmentText': appointmentText,
      'doctor': doctor?.toJson(),
      'doctorTc': doctorTc,
      'patient': patient?.toJson(),
      'patientTc': patientTc,
      'status': status,
    };
  }
}
