
class SubscriptionPlan {
  final int? id;
  final String? name;
  final double? price;
  final int? durationInMonths;

  SubscriptionPlan({
    this.id,
    this.name,
    this.price,
    this.durationInMonths,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      durationInMonths: json['durationInMonths'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'durationInMonths': durationInMonths,
    };
  }
}
