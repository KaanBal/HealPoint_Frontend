enum PaymentStatus {AYLIK, YILLIK} // PaymentStatus Enum

class Payments {
  final int Payment_id;
  final double amount;
  final PaymentStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Payments({
    required this.Payment_id,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON'dan nesneye dönüştürme
factory Payments.fromJson(Map<String, dynamic> json) {
  return Payments(
    Payment_id: json['Payment_id'] ?? "", // Default to empty string if null
    amount: (json['Amount'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    status: PaymentStatus.values
        .firstWhere((e) => e.toString() == 'PaymentStatus.${json['status']}'),
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : DateTime.fromMillisecondsSinceEpoch(0), // Default to epoch if null
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : DateTime.fromMillisecondsSinceEpoch(0), // Default to epoch if null
  );
}

}
