import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/models/Patients.dart';

class Reviews {
  final int reviewId;
  final String? comment;
  final int? points;
  final DateTime? createdAt;
  final Patients? patient;
  final Doctors? doctor;
  final Appointments? appointment;

  Reviews({
    required this.reviewId,
    this.createdAt,
    this.comment,
    this.points,
    this.patient,
    this.doctor,
    this.appointment,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      reviewId: json['reviewId'],
      comment: json['comment'],
      points: json['points'],
      patient:
          json['patient'] != null ? Patients.fromJson(json['patient']) : null,
      doctor: json['doctor'] != null ? Doctors.fromJson(json['doctor']) : null,
      appointment: json['appointment'] != null
          ? Appointments.fromJson(json['appointment'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
