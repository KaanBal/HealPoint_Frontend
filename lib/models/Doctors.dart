import 'package:yazilim_projesi/models/Patients.dart';
import 'package:yazilim_projesi/models/Payments.dart';
import 'package:yazilim_projesi/models/Reviews.dart';

class Doctors {
  final String Doctor_tc;
  final String Doctor_name;
  final String? branch;
  final String? Doctor_surname;
  final String? Doctor_phonenumber;
  final String? Doctor_password;
  final String? Doctor_email;
  final String? city;
  final String? district;
  final String? address;
  final List<Patients>? patients;
  final List<Payments>? payments;
  final List<Reviews>? reviews;

  Doctors({
    required this.Doctor_tc,
    required this.Doctor_name,
    this.branch,
    this.Doctor_surname,
    this.Doctor_phonenumber,
    this.Doctor_password,
    this.Doctor_email,
    this.city,
    this.district,
    this.address,
    this.patients,
    this.payments,
    this.reviews,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) {
    return Doctors(
      Doctor_tc: json['Doctor_tc'],
      Doctor_name: json['Doctor_name'],
      branch: json['branch'],
      Doctor_surname: json['Doctor_surname'],
      Doctor_phonenumber: json['Doctor_phonenumber'],
      Doctor_password: json['Doctor_password'],
      Doctor_email: json['Doctor_email'],
      city: json['city'],
      district: json['district'],
      address: json['address'],
      patients: json['patients'] != null
          ? List<Patients>.from(
              json['patients'].map((pat) => Patients.fromJson(pat)))
          : null,
      payments: json['payments'] != null
          ? List<Payments>.from(
              json['payments'].map((pay) => Payments.fromJson(pay)))
          : null,
      reviews: json['reviews'] != null
          ? List<Reviews>.from(
              json['reviews'].map((rev) => Reviews.fromJson(rev)))
          : null,
    );
  }
}
