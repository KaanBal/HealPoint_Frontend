import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/abonelik_onaylama.dart';
import 'package:yazilim_projesi/models/SubscriptionPlan.dart';
import 'package:yazilim_projesi/services/subscription_service.dart';

class AboneOl extends StatefulWidget {
  const AboneOl({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<AboneOl> {
  SubscriptionPlan? selectedSubscription;

  SubscriptionService subsService = SubscriptionService();
  List<SubscriptionPlan> subscriptionPlans = [];

  @override
  void initState() {
    super.initState();
    fetchSubscriptionPlans();
  }

  Future<void> fetchSubscriptionPlans() async {
    try {
      final response = await subsService.getAllPlans();
      if (response.statusCode == 200) {
        final List<dynamic> plansJson = response.data;
        final plans =
            plansJson.map((plan) => SubscriptionPlan.fromJson(plan)).toList();
        setState(() {
          subscriptionPlans = plans;
          if (subscriptionPlans.isNotEmpty) {
            selectedSubscription = subscriptionPlans.first;
          }
        });
      } else {
        print("Failed to fetch plans: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void navigateToConfirmation(BuildContext context) {
    if (selectedSubscription != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AbonelikOnaylama(
            subPlan: selectedSubscription, 
          ),
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
        child: subscriptionPlans.isEmpty
            ? const Center(
                child: Text(
                  'Plan bulunamadı!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: subscriptionPlans.length,
                itemBuilder: (context, index) {
                  final plan = subscriptionPlans[index];
                  return Column(
                    children: [
                      SubscriptionCard(
                        title: plan.name ?? "",
                        description: '${plan.durationInMonths} ay boyunca erişim.',
                        price: '₺${plan.price?.toStringAsFixed(2)}',
                        color: index.isEven
                            ? Colors.blueAccent
                            : Colors.greenAccent,
                        isSelected: selectedSubscription == plan,
                        onPressed: () {
                          setState(() {
                            selectedSubscription = plan;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateToConfirmation(context);
        },
        label: const Text('Onayla'),
        icon: const Icon(Icons.check),
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

  const SubscriptionCard({
    super.key,
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
