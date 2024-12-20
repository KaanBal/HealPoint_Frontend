import 'package:yazilim_projesi/models/Appointments.dart';

class Patients {
  final String patientTc;
  final String Patient_name;
  final String Patient_surname;
  final String? Patient_gender;
  final String? patientPhoneNumber;
  final String? patientEmail;
  final String? Patient_password;
  final DateTime? birthDate;
  final List<Appointments>? appointments;

  Patients({
    required this.patientTc,
    required this.Patient_name,
    required this.Patient_surname,
    this.Patient_gender,
    this.patientPhoneNumber,
    this.patientEmail,
    this.Patient_password,
    this.birthDate,
    this.appointments,
  });

  factory Patients.fromJson(Map<String, dynamic> json) {
    return Patients(
      patientTc: json['tc'],
      Patient_name: json['name'],
      Patient_surname: json['surname'],
      Patient_gender: json['gender'],
      patientPhoneNumber: json['phoneNumber'],
      patientEmail: json['email'],
      Patient_password: json['password'],
      birthDate: json['birthDate'],
      appointments: json['appointments'] != null
          ? List<Appointments>.from(
              json['appointments'].map((app) => Appointments.fromJson(app)))
          : null,
    );
  }
}
