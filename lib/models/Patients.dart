import 'package:yazilim_projesi/models/Appointments.dart';

class Patients {
  String? Tc;
  String? name;
  String? surname;
  String? gender;
  String? phoneNumber;
  String? email;
  String? password;
  DateTime? birthDate;
  int? age;
  List<Appointments>? appointments;

  Patients({
    this.Tc,
    this.name,
    this.surname,
    this.gender,
    this.phoneNumber,
    this.email,
    this.password,
    this.birthDate,
    this.age,
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
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate']) 
          : null,
      age: json['age'] != null ? json['age'] as int : null, 
      appointments: json['appointments'] != null
          ? List<Appointments>.from(
              json['appointments'].map((app) => Appointments.fromJson(app))) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Tc': Tc,
      'name': name,
      'surname': surname,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'birthDate': birthDate?.toIso8601String(), // Serialize as ISO-8601
      'age': age, // Direct assignment as int
      'appointments': appointments?.map((app) => app.toJson()).toList(), // Convert Appointments list
    };
  }
}
