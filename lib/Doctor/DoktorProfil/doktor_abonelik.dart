import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/abone_ol.dart';
import 'package:yazilim_projesi/models/Subscription.dart';
import 'package:yazilim_projesi/services/subscription_service.dart';

class AbonelikBilgiSayfasi extends StatefulWidget {
  const AbonelikBilgiSayfasi({super.key});

  @override
  _AbonelikBilgiSayfasiState createState() => _AbonelikBilgiSayfasiState();
}

class _AbonelikBilgiSayfasiState extends State<AbonelikBilgiSayfasi> {
  final SubscriptionService subService = SubscriptionService();
  Subscription? doctorSub;
  bool hasError = false;

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  Future<void> fetchDoctorSubPlan() async {
    try {
      final response = await subService.getDoctorSubscription();
      setState(() {
        doctorSub = Subscription.fromJson(response.data);
        hasError = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
      });
    }
  }

  void _loadDataFromMockData() async {
    const String jsonFile = 'assets/MockData/subscription.json';
    final dataString = await rootBundle.loadString(jsonFile);
    final Map<String, dynamic> dataJson = jsonDecode(dataString);
    setState(() {
      doctorSub = Subscription.fromJson(dataJson);
      hasError = false;
    });
  }

  @override
  void initState() {
    super.initState();
    //_loadDataFromMockData();
    fetchDoctorSubPlan();
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
        child: hasError
            ? _buildErrorState(context)
            : doctorSub == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildSubscriptionDetails(),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Abonelik bulunamadı!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboneOl(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 50),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Aboneliği Düzenle'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSubscriptionDetails() {
    final double buttonWidth = MediaQuery.of(context).size.width - 32;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Abonelik Bilgileri',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: buttonWidth,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                },
                children: [
                  TableRow(children: [
                    const Text('Abonelik Türü:',
                        style: TextStyle(fontSize: 16)),
                    Text(doctorSub!.planName ?? '',
                        style: const TextStyle(fontSize: 16)),
                  ]),
                  const TableRow(
                      children: [SizedBox(height: 8), SizedBox(height: 8)]),
                  TableRow(children: [
                    const Text('Başlangıç Tarihi:',
                        style: TextStyle(fontSize: 16)),
                    Text(formatDate(doctorSub!.startDate!),
                        style: const TextStyle(fontSize: 16)),
                  ]),
                  const TableRow(
                      children: [SizedBox(height: 8), SizedBox(height: 8)]),
                  TableRow(children: [
                    const Text('Bitiş Tarihi:', style: TextStyle(fontSize: 16)),
                    Text(formatDate(doctorSub!.endDate!),
                        style: const TextStyle(fontSize: 16)),
                  ]),
                  const TableRow(
                      children: [SizedBox(height: 8), SizedBox(height: 8)]),
                  TableRow(children: [
                    const Text('Durum:', style: TextStyle(fontSize: 16)),
                    Text(
                      doctorSub!.isActive! ? 'Aktif' : 'Pasif',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboneOl(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 17),
            minimumSize: Size(buttonWidth, 50),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Aboneliği Düzenle'),
        ),
        const Spacer(),
        Divider(color: Colors.grey[400], thickness: 1),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            'Aboneliğinizi her zaman yönetebilirsiniz.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
