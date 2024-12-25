
class Subscription {
  final int? id;
  final int? planId;
  final String? planName; 
  final DateTime? startDate;
  final DateTime? endDate; 
  final bool? isActive;

  Subscription({
    this.id,
    this.planId,
    this.planName,
    this.startDate,
    this.endDate,
    this.isActive,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      planId: json['planId'],
      planName: json['planName'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'planId': planId,
      'planName': planName,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isActive': isActive,
    };
  }
}
