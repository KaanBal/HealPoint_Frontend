class DoctorAvailability {
  final String? workingHoursStart;
  final String? workingHoursEnd;
  final String? availableDate;
  final List<String>? availableTimes;

  DoctorAvailability({
    this.workingHoursStart,
    this.workingHoursEnd,
    this.availableDate,
    this.availableTimes,
  });

  factory DoctorAvailability.fromJson(Map<String, dynamic> json) {
    return DoctorAvailability(
      workingHoursStart: json['workingHoursStart'] as String?,
      workingHoursEnd: json['workingHoursEnd'] as String?,
      availableDate: json['availableDate'] as String?,
      availableTimes: (json['availableTimes'] as List<dynamic>?) 
          ?.map((item) => item as String) 
          .toList(),
    );
  }

  /// Convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'workingHoursStart': workingHoursStart,
      'workingHoursEnd': workingHoursEnd,
      'availableDate': availableDate,
      'availableTimes': availableTimes, 
    };
  }
}
