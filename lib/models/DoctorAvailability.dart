class DoctorAvailability {
  final String? availableDate;
  final List<String>? availableTimes;

  DoctorAvailability({
    this.availableDate,
    this.availableTimes,
  });

  factory DoctorAvailability.fromJson(Map<String, dynamic> json) {
    return DoctorAvailability(
      availableDate: json['availableDate'] as String?,
      availableTimes: (json['availableTimes'] as List<dynamic>?) 
          ?.map((item) => item as String) 
          .toList(),
    );
  }

  /// Convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'availableDate': availableDate,
      'availableTimes': availableTimes, 
    };
  }
}
