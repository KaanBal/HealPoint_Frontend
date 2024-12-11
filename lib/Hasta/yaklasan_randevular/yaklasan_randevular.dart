import 'package:flutter/material.dart';

class YaklasanRandevular extends StatelessWidget {
  final List<Map<String, String>> yaklasanRandevular = [
    {
      "saat": "09:30",
      "tarih": "12.12.2024",
      "doktorIsmi": "Dr. Ahmet Yılmaz",
      "hastane": "Acıbadem Hastanesi",
      "brans": "Kardiyoloji",
      "durum": "Yaklaşan Randevu",
    },
    {
      "saat": "14:00",
      "tarih": "15.12.2024",
      "doktorIsmi": "Dr. Zeynep Kaya",
      "hastane": "Memorial Hastanesi",
      "brans": "Dahiliye",
      "durum": "Yaklaşan Randevu",
    },
    {
      "saat": "16:00",
      "tarih": "20.12.2024",
      "doktorIsmi": "Dr. Mehmet Demir",
      "hastane": "Florence Nightingale Hastanesi",
      "brans": "Nöroloji",
      "durum": "Yaklaşan Randevu",
    },
  ];

  Map<String, String> getEnYakinRandevu() {
    yaklasanRandevular.sort((a, b) {
      DateTime tarihA =
          DateTime.parse(a["tarih"]!.split('.').reversed.join('-'));
      DateTime tarihB =
          DateTime.parse(b["tarih"]!.split('.').reversed.join('-'));
      return tarihA.compareTo(tarihB);
    });
    return yaklasanRandevular.first;
  }

  @override
  Widget build(BuildContext context) {
    final enYakinRandevu = getEnYakinRandevu();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yaklaşan Randevular"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.blue.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "En Yakın Randevu",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${enYakinRandevu["tarih"]} - ${enYakinRandevu["saat"]}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Doktor: ${enYakinRandevu["doktorIsmi"]}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Hastane: ${enYakinRandevu["hastane"]}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: yaklasanRandevular.length,
                itemBuilder: (context, index) {
                  final randevu = yaklasanRandevular[index];
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
                                "${randevu["tarih"]} - ${randevu["saat"]}",
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
                                child: Text(
                                  randevu["durum"]!,
                                  style: const TextStyle(
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
                            "Doktor İsmi: ${randevu['doktorIsmi']}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Branş: ${randevu['brans']}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            randevu["hastane"]!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
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
