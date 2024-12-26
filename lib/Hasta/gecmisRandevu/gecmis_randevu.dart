import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yazilim_projesi/Hasta/gecmisRandevu/gecmisRandevu_fonks.dart';
import 'package:yazilim_projesi/Hasta/yorum/hasta_yorum.dart';
import 'package:yazilim_projesi/models/Appointments.dart';

class GecmisRandevular extends StatefulWidget {
  const GecmisRandevular({super.key});

  @override
  State<GecmisRandevular> createState() => _GecmisRandevularState();
}

class _GecmisRandevularState extends State<GecmisRandevular> {
  final GecmisRandevuFonks fonks = GecmisRandevuFonks();
  List<Appointments> pastAppointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDataFromMockData();
    //_loadData();
  }

  Future<void> _loadData() async {
    try {
      final appointments = await fonks.fetchPastAppointments();
      setState(() {
        pastAppointments = appointments;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata oluştu: $e")),
      );
    }
  }

  void _loadDataFromMockData() async {
    const String jsonFile = 'assets/MockData/past_appointment.json';
    final dataString = await rootBundle.loadString(jsonFile);
    final List<dynamic> dataJson = jsonDecode(dataString);
    setState(() {
      pastAppointments =
          dataJson.map((json) => Appointments.fromJson(json)).toList();
      isLoading = false;
    });
  }

  Widget _buildRatingButton(Appointments appointment, String statusText) {
    // Sadece tamamlanmış randevular için değerlendirme butonu göster
    if (statusText.toLowerCase() == "tamamlandı") {
      return TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorRatingScreen()));
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            decorationColor: Colors.blue,
            decorationThickness: 2,
          ),
        ),
        child: const Text("Değerlendir"),
      );
    }
    // Diğer durumlar için boş container döndür
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geçmiş Randevular"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: pastAppointments.length,
                itemBuilder: (context, index) {
                  final pastAppointment = pastAppointments[index];
                  final statusText =
                      fonks.statusToText(pastAppointment.appointmentStatus);
                  final statusColor =
                      fonks.statusColor(pastAppointment.appointmentStatus);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${pastAppointment.appointmentDate?.toLocal().toString().split(' ')[0]} - ${pastAppointment.appointmentTime?.format(context) ?? 'Saat Bilgisi Yok'}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  statusText,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Doktor İsmi: ${pastAppointment.doctor?.name ?? 'Bilinmiyor'}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Branş: ${pastAppointment.doctor?.branch ?? 'Bilinmiyor'}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                pastAppointment.doctor?.city ??
                                    "Şehir Bilgisi Yok",
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: _buildRatingButton(pastAppointment, statusText),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
