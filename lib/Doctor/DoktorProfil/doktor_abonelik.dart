import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/abone_ol.dart';

class AbonelikBilgiSayfasi extends StatefulWidget {
  const AbonelikBilgiSayfasi({super.key});

  @override
  _AbonelikBilgiSayfasiState createState() => _AbonelikBilgiSayfasiState();
}

class _AbonelikBilgiSayfasiState extends State<AbonelikBilgiSayfasi> {

  DateTime startDate = DateTime(2023, 10, 1);
  DateTime endDate = DateTime(2024, 10, 1);

  String subscriptionType = 'Bireysel (3 Ay)';
  String cancelDateMessage = '';
  String cancelStatusMessage = '';

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abonelik Bilgileri'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aboneliğiniz',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Başlangıç Tarihi: ${formatDate(startDate)}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Bitiş Tarihi: ${formatDate(endDate)}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Seçenekler Kısmı
            const Text(
              'Seçenekler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Bireysel (3 Ay)'),
                    subtitle: const Text(
                      'Fiyat: 99.99 TL',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                    leading: Radio<String>(
                      value: 'Bireysel (3 Ay)',
                      groupValue: subscriptionType,
                      onChanged: (value) {
                        setState(() {
                          subscriptionType = value!;
                        });
                      },
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('1 Yıl'),
                    subtitle: const Text(
                      'Fiyat: 299.99 TL (İlk Ay Ücretsiz)',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                    leading: Radio<String>(
                      value: '1 Yıl',
                      groupValue: subscriptionType,
                      onChanged: (value) {
                        setState(() {
                          subscriptionType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  cancelStatusMessage = 'Aboneliğiniz iptal edilmiştir.(Aboneliğinizin bitiş tarihine kadar uygulamamızı kullanabilirsiniz.)'; // İptal mesajı
                  cancelDateMessage = '';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Buton rengi
                padding: const EdgeInsets.symmetric(vertical: 17),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Aboneliği İptal Et'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboneOl()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Buton rengi
                padding: const EdgeInsets.symmetric(vertical: 17),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Aboneliği Düzenle'),
            ),

            const SizedBox(height: 20),
            if (cancelDateMessage.isNotEmpty) ...[
              Text(
                cancelDateMessage,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
            if (cancelStatusMessage.isNotEmpty) ...[
              Text(
                cancelStatusMessage,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
            const SizedBox(height: 20),

            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Aboneliğinizi her zaman yönetebilirsiniz.',
              style: TextStyle(fontSize: 14, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}