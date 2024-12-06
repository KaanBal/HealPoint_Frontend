import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/models/Doctors.dart';

class Patients {
  final String patientTc;
  final String Patient_name;
  final String Patient_surname;
  final String? Patient_gender;
  final String patientPhoneNumber;
  final String patientEmail;
  final String Patient_password;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Doctors>? doctors;
  final List<Appointments>? appointments;

  Patients({
    required this.patientTc,
    required this.Patient_name,
    required this.Patient_surname,
    this.Patient_gender,
    required this.patientPhoneNumber,
    required this.patientEmail,
    required this.Patient_password,
    required this.createdAt,
    required this.updatedAt,
    this.doctors,
    this.appointments,
  });

  // JSON'dan nesneye dönüştürme
  factory Patients.fromJson(Map<String, dynamic> json) {
    return Patients(
      patientTc: json['patientTc'],
      Patient_name: json['Patient_name'],
      Patient_surname: json['Patient_surname'],
      Patient_gender: json['Patient_gender'],
      patientPhoneNumber: json['patientPhoneNumber'],
      patientEmail: json['patientEmail'],
      Patient_password: json['Patient_password'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      doctors: json['doctors'] != null
          ? List<Doctors>.from(
              json['doctors'].map((doc) => Doctors.fromJson(doc)))
          : null,
      appointments: json['appointments'] != null
          ? List<Appointments>.from(
              json['appointments'].map((app) => Appointments.fromJson(app)))
          : null,
    );
  }
}
