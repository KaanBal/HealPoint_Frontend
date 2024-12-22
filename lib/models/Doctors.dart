
import 'package:yazilim_projesi/models/Reviews.dart';

class Doctors {
  final String? tc;
  final String? name;
  final String? branch;
  final String? surname;
  final String? phoneNumber;
  final String? about;
  final String? password;
  final String? gender;
  final String? email;
  final String? city;
  final String? district;
  final String? address;
  final double? avgPoint;
  final bool? isAccountActive;
  final List<Reviews>? reviews;

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
    this.reviews,
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
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((review) => Reviews.fromJson(review))
          .toList(),
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
      'reviews': reviews?.map((review) => review.toJson()).toList(),
    };
  }

}
