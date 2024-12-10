import 'package:flutter/material.dart';

class GecmisRandevular extends StatelessWidget {
  final List<Map<String, String>> gecmisRandevular = [
    {
      "saat": "09:30",
      "tarih": "10.12.2024",
      "doktorIsmi": "Dr. Ahmet Yılmaz",
      "hastane": "Acıbadem Hastanesi",
      "brans": "Kardiyoloji",
      "durum": "Muayene Olundu",
    },
    {
      "saat": "14:00",
      "tarih": "08.12.2024",
      "doktorIsmi": "Dr. Zeynep Kaya",
      "hastane": "Memorial Hastanesi",
      "brans": "Dahiliye",
      "durum": "İptal Edildi",
    },
    {
      "saat": "16:00",
      "tarih": "05.12.2024",
      "doktorIsmi": "Dr. Mehmet Demir",
      "hastane": "Florence Nightingale Hastanesi",
      "brans": "Nöroloji",
      "durum": "Muayene Olundu",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geçmiş Randevular"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: gecmisRandevular.length,
          itemBuilder: (context, index) {
            final randevu = gecmisRandevular[index];
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
                            color: randevu["durum"] == "İptal Edildi"
                                ? Colors.red.withOpacity(0.2)
                                : Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            randevu["durum"]!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: randevu["durum"] == "İptal Edildi"
                                  ? Colors.red
                                  : Colors.green,
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
    );
  }
}


