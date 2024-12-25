class Payment {
  final double? amount;
  final String? cardNumber;
  final String? cardHolderName;
  final String? expiryDate;
  final String? cvv;
  final int? planId;

  Payment({
    this.amount,
    this.cardNumber,
    this.cardHolderName,
    this.expiryDate,
    this.cvv,
    this.planId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      amount: json['amount']?.toDouble() ?? 0.0,
      cardNumber: json['cardNumber'] ?? '',
      cardHolderName: json['cardHolderName'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      cvv: json['cvv'] ?? '',
      planId: json['planId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'planId': planId,
    };
  }
}
