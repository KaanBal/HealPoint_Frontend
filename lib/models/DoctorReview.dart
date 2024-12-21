class DoctorReview {
  final String? doctorName;
  final String? doctorSurname;
  final String? branch;
  final String? city;
  final String? email;

  DoctorReview({
    this.doctorName,
    this.doctorSurname,
    this.branch,
    this.city,
    this.email,
  });

  factory DoctorReview.fromJson(Map<String, dynamic> json) {
    return DoctorReview(
      doctorName: json['doctorName'],
      doctorSurname: json['doctorSurname'],
      branch: json['branch'],
      city: json['city'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorName': doctorName,
      'doctorSurname': doctorSurname,
      'branch': branch,
      'city': city,
      'email': email,
    };
  }
}
