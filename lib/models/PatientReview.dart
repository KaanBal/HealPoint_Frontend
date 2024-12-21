class PatientReview {
  final String? patientName;
  final String? patientSurname;
  final String? patientGender;

  PatientReview({
    this.patientName,
    this.patientSurname,
    this.patientGender,
  });

  factory PatientReview.fromJson(Map<String, dynamic> json) {
    return PatientReview(
      patientName: json['patientName'],
      patientSurname: json['patientSurname'],
      patientGender: json['patientGender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'patientSurname': patientSurname,
      'patientGender': patientGender,
    };
  }
}
