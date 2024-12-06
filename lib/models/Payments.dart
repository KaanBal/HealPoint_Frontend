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
      Payment_id: json['paymPayment_identId'],
      amount:
          (json['Amount'] as num).toDouble(), // JSON'dan double'e dönüştürme
      status: PaymentStatus.values
          .firstWhere((e) => e.toString() == 'PaymentStatus.${json['status']}'),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
