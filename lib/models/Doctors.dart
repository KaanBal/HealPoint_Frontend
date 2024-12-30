
class Doctors {
  String? tc;
  String? name;
  String? branch;
  String? surname;
  String? phoneNumber;
  String? about;
  String? password;
  String? gender;
  String? email;
  String? city;
  String? district;
  String? address;
  double? avgPoint;
  bool? isAccountActive;


  Doctors({
    this.tc,
    this.name,
    this.surname,
    this.email,
    this.phoneNumber,
    this.password,
    this.gender,
    this.branch,
    this.about,
    this.city,
    this.district,
    this.address,
    this.avgPoint,
    this.isAccountActive,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) {
    return Doctors(
      tc: json['tc'],
      name: json['name'],
      branch: json['branch'],
      surname: json['surname'],
      phoneNumber: json['phoneNumber'],
      about: json['about'],
      password: json['password'],
      gender: json['gender'],
      email: json['email'],
      city: json['city'],
      district: json['district'],
      address: json['address'],
      avgPoint: (json['avgPoint'] as num?)?.toDouble(),
      isAccountActive: json['isAccountActive'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tc': tc,
      'name': name,
      'branch': branch,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'about': about,
      'password': password,
      'gender': gender,
      'email': email,
      'city': city,
      'district': district,
      'address': address,
      'avgPoint': avgPoint,
      'isAccountActive': isAccountActive,
    };
  }
}
