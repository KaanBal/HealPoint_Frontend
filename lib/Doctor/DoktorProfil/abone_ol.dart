import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/abonelik_onaylama.dart';

class AboneOl extends StatefulWidget {
  const AboneOl({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<AboneOl> {
  String selectedSubscription = '';

  void toggleSelection(String subscription) {
    setState(() {
      if (selectedSubscription == subscription) {
        selectedSubscription = '';
      } else {
        selectedSubscription = subscription;
      }
    });
  }

  void navigateToConfirmation(BuildContext context) {
    if (selectedSubscription.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AbonelikOnaylama(subscription: selectedSubscription),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir abonelik seçin.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abonelik Seçimi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SubscriptionCard(
              title: '3 Aylık Abonelik',
              description: 'Yalnızca 3 ay boyunca erişim sağlayın.',
              price: '₺99.99',
              color: Colors.blueAccent,
              isSelected: selectedSubscription == '3 Aylık',
              onPressed: () {
                toggleSelection('3 Aylık');
              },
            ),
            const SizedBox(height: 16),
            SubscriptionCard(
              title: '1 Yıllık Abonelik',
              description: 'İlk ay ücretsiz! 1 yıl boyunca erişim.',
              price: '₺299.99',
              color: Colors.greenAccent,
              isSelected: selectedSubscription == '1 Yıllık',
              onPressed: () {
                toggleSelection('1 Yıllık');
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => navigateToConfirmation(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Onayla'),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final Color color;
  final bool isSelected;
  final VoidCallback onPressed;

  const SubscriptionCard({super.key, 
    required this.title,
    required this.description,
    required this.price,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPressed,
                    child: Text(isSelected ? 'Seçildi' : 'Seç'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
