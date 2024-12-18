import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AbonelikOnaylama extends StatefulWidget {
  final String subscription;

  const AbonelikOnaylama({super.key, required this.subscription});

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<AbonelikOnaylama> {
  bool isLoading = false;
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController adsoyadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cardNumberController.addListener(_updateFormState);
    expiryDateController.addListener(_updateFormState);
    cvvController.addListener(_updateFormState);
    adsoyadController.addListener(_updateFormState);
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    adsoyadController.dispose();
    super.dispose();
  }

  bool get isFormValid {
    return cardNumberController.text.length == 16 &&
        expiryDateController.text.length == 5 &&
        cvvController.text.length == 3 &&
        adsoyadController.text.isNotEmpty;
  }

  void _updateFormState() {
    setState(() {});
  }

  void processPayment() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ödeme başarıyla tamamlandı.')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String price = widget.subscription == '3 Aylık' ? '₺99.99' : '₺299.99';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Abone Onaylama'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Seçilen Abonelik: ${widget.subscription}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Tutar: $price',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: adsoyadController,
              decoration: const InputDecoration(
                labelText: "Ad ve Soyad",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(
                    r'[a-zA-ZğüşöçıİĞÜŞÖÇ\s]')),
                LengthLimitingTextInputFormatter(50),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cardNumberController,
              decoration: const InputDecoration(
                labelText: 'Kart Numarası',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: expiryDateController,
              decoration: const InputDecoration(
                labelText: 'Son Kullanma Tarihi (MM/YY)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d|/')),
                LengthLimitingTextInputFormatter(5),
                ExpiryDateInputFormatter(),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cvvController,
              decoration: const InputDecoration(
                labelText: 'CVV',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading || !isFormValid ? null : processPayment,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Ödeme Yap'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (text.length > 2) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    }
    if (text.length > 5) {
      text = text.substring(0, 5);
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
