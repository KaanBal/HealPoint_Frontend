import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/models/Appointments.dart';

class YaklasanRandevular extends StatelessWidget {
  final List<Appointments> appointments;

  const YaklasanRandevular({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    final enYakinRandevu = appointments.isNotEmpty ? appointments[0] : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yaklaşan Randevular"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (enYakinRandevu != null)
              Card(
                color: Colors.blue,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "En Yakın Randevu",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Yaklaşan Randevu",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${DateFormat('dd.MM.yyyy').format(enYakinRandevu.appointmentDate!)} - ${enYakinRandevu.appointmentTime!.hour.toString().padLeft(2, '0')}:${enYakinRandevu.appointmentTime!.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Doktor İsmi: ${enYakinRandevu.doctor?.name} ${enYakinRandevu.doctor?.surname}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Branş: ${enYakinRandevu.doctor?.branch}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton.icon(
                          onPressed: () {
                            // İptal işlemi için onay dialog'u göster
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Randevu İptali"),
                                  content: const Text("Randevuyu iptal etmek istediğinize emin misiniz?"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Hayır"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Evet"),
                                      onPressed: () {
                                        // İptal işlemi burada gerçekleştirilecek
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.cancel, color: Colors.white70, size: 20),
                          label: const Text(
                            "İptal Et",
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              const Center(
                child: Text(
                  "Yaklaşan bir randevunuz yok.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            if (appointments.length > 1)
              Expanded(
                child: ListView.builder(
                  itemCount: appointments.length - 1,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index + 1];
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
                                  "${DateFormat('dd.MM.yyyy').format(appointment.appointmentDate!)} - ${appointment.appointmentTime!.hour.toString().padLeft(2, '0')}:${appointment.appointmentTime!.minute.toString().padLeft(2, '0')}",
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
                                    color: Colors.blue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "Yaklaşan Randevu",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Doktor İsmi: ${appointment.doctor?.name} ${appointment.doctor?.surname}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Branş: ${appointment.doctor?.branch}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Randevu İptali"),
                                        content: const Text("Randevuyu iptal etmek istediğinize emin misiniz?"),
                                        actions: [
                                          TextButton(
                                            child: const Text("Hayır"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Evet"),
                                            onPressed: () {
                                              // İptal işlemi burada gerçekleştirilecek
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.cancel, color: Colors.blue, size: 20),
                                label: const Text(
                                  "İptal Et",
                                  style: TextStyle(color: Colors.blue, fontSize: 14),
                                ),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}