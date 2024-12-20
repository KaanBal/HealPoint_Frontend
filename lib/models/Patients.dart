import 'package:yazilim_projesi/models/Appointments.dart';

class Patients {
  final String Tc;
  final String name;
  final String surname;
  final String? gender;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final DateTime? birthDate;
  final List<Appointments>? appointments;

  Patients({
    required this.Tc,
    required this.name,
    required this.surname,
    this.gender,
    this.phoneNumber,
    this.email,
    this.password,
    this.birthDate,
    this.appointments,
  });

  factory Patients.fromJson(Map<String, dynamic> json) {
    return Patients(
      Tc: json['Tc'],
      name: json['name'],
      surname: json['surname'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      birthDate: json['birthDate'],
      appointments: json['appointments'] != null
          ? List<Appointments>.from(
              json['appointments'].map((app) => Appointments.fromJson(app)))
          : null,
    );
  }
}
