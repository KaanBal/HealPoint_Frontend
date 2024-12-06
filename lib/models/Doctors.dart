import 'package:yazilim_projesi/models/Patients.dart';
import 'package:yazilim_projesi/models/Payments.dart';
import 'package:yazilim_projesi/models/Reviews.dart';

class Doctors {
  final String Doctor_tc;
  final String Doctor_name;
  final String branch;
  final String Doctor_surname;
  final String Doctor_phonenumber;
  final String Doctor_password;
  final String Doctor_email;
  final String city;
  final String district;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Patients>? patients;
  final List<Payments>? payments;
  final List<Reviews>? reviews;

   Doctors({
    required this.Doctor_tc,
    required this.Doctor_name,
    required this.branch,
    required this.Doctor_surname,
    required this.Doctor_phonenumber,
    required this.Doctor_password,
    required this.Doctor_email,
    required this.city,
    required this.district,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    this.patients,
    this.payments,
    this.reviews,
  });


  // JSON'dan nesneye dönüştürme
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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