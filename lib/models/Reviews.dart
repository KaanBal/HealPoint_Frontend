import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/models/Patients.dart';

class Reviews {
  final int reviewId;
  final String comments;
  final int points;
  final DateTime createdAt;
  final Patients patient;
  final Doctors doctor;
  final Appointments appointment;

  Reviews({
    required this.reviewId,
    required this.comments,
    required this.points,
    required this.createdAt,
    required this.patient,
    required this.doctor,
    required this.appointment,
  });

  // JSON'dan nesneye dönüştürme
  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      reviewId: json['Review_id'],
      comments: json['comments'],
      points: json['points'],
      createdAt: DateTime.parse(json['created_at']),
      patient: Patients.fromJson(json['patient']),
      doctor: Doctors.fromJson(json['doctor']),
      appointment: Appointments.fromJson(json['appointment']),
    );
  }
}
