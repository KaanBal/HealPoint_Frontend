import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class DoctorBilgiEkran extends StatelessWidget {
  const DoctorBilgiEkran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    final double ekranYuksekligi = ekranBilgisi.size.height;

    // Calculate scaled font sizes and padding based on screen width
    double fontSize = ekranGenisligi / 22;  // Font boyutunu biraz küçülttük
    double padding = ekranGenisligi * 0.05;

    final List<Map<String, String>> yorumlar = [
      {
        'isim': 'Ahmet Yılmaz',
        'yorum': 'Doktor Anderson çok ilgiliydi ve her sorumu dikkatle yanıtladı. Çok memnun kaldım.',
        'tarih': '01.12.2024',
      },
      {
        'isim': 'Fatma Kaya',
        'yorum': 'Son derece profesyonel ve güler yüzlü bir yaklaşım. Tavsiye ederim!',
        'tarih': '05.12.2024',
      },
      {
        'isim': 'Mehmet Can',
        'yorum': 'Tedavi sürecimde bana çok destek oldu. Harika bir doktor.',
        'tarih': '07.12.2024',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doktor Bilgisi',
          style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: acikKirmizi,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doktor Profili ve Bilgiler
            Stack(
              children: [
                const Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('resimler/doktor.png'),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Dr. William Anderson',
                            style: TextStyle(
                                fontSize: 19,  // Font boyutunu küçülttük
                                fontFamily: "ABeeZee",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Ürolog',
                            style: TextStyle(
                                fontSize: 17,  // Font boyutunu küçülttük
                                fontFamily: "PtSans",
                                color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 18),
                              SizedBox(width: 5),
                              Text('4.7', style: TextStyle(fontSize: 15)),  // Font boyutunu küçülttük
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      print("Resim tıklandı!");
                    },
                    child: Image.asset(
                      'resimler/click.png',
                      width: 25,
                      height: 30,
                      color: acikKirmizi,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ekranYuksekligi * 0.05),

            // Doktor Hakkında Bilgi
            Text(
              'Doktor Hakkında',
              style: TextStyle(
                  fontSize: fontSize * 1.1,  // Font boyutunu küçülttük
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Dr. Anderson is a highly respected and experienced psychiatrist known for his compassionate care and comprehensive approach to mental health. With over 15 years of experience in the field, Dr. Anderson...',
              style: TextStyle(
                  fontSize: fontSize,  // Font boyutunu küçülttük
                  fontFamily: "PtSans",
                  color: Colors.black87),
            ),
            SizedBox(height: ekranYuksekligi * 0.07),

            // Çalışma Saatleri
            Text(
              'Çalışma Saatleri',
              style: TextStyle(
                  fontSize: fontSize * 1.1,  // Font boyutunu küçülttük
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Pazartesi - Cuma, 08:00  - 18:00 ',
              style: TextStyle(
                  fontSize: fontSize,  // Font boyutunu küçülttük
                  fontFamily: "ABeeZee",
                  color: Colors.black87),
            ),
            SizedBox(height: ekranYuksekligi * 0.07),

            // Yorumlar
            Text(
              'Yorumlar',
              style: TextStyle(
                  fontSize: fontSize * 1.1,  // Font boyutunu küçülttük
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: ekranYuksekligi * 0.25, // Kaydırılabilir alan yüksekliği
              child: ListView.builder(
                itemCount: yorumlar.length,
                itemBuilder: (context, index) {
                  final yorum = yorumlar[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: padding / 2),
                    child: Padding(
                      padding: EdgeInsets.all(padding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            yorum['isim']!,
                            style: TextStyle(
                                fontSize: fontSize,  // Font boyutunu küçülttük
                                fontWeight: FontWeight.bold,
                                fontFamily: "ABeeZee"),
                          ),
                          SizedBox(height: 5),
                          Text(
                            yorum['yorum']!,
                            style: TextStyle(
                                fontSize: fontSize * 0.9,  // Font boyutunu küçülttük
                                fontFamily: "PtSans",
                                color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          Text(
                            yorum['tarih']!,
                            style: TextStyle(
                                fontSize: fontSize * 0.8,  // Font boyutunu küçülttük
                                fontFamily: "PtSans",
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: ekranYuksekligi * 0.07),

            // Uygun Saatler
            Text(
              'Uygun Saatler:',
              style: TextStyle(
                  fontSize: fontSize * 1.1,  // Font boyutunu küçülttük
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['08:00  ', '10:00  ', '12:00  ']
                  .map((time) => ElevatedButton(
                onPressed: () {
                  // Randevu alınabilir
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: acikKirmizi,
                  foregroundColor: beyaz,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(time),
              ))
                  .toList(),
            ),
            SizedBox(height: ekranYuksekligi * 0.07),

            // Randevu Al Butonu
            ElevatedButton(
              onPressed: () {
                // Randevu alma işlemi
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(ekranGenisligi, 50),
                backgroundColor: acikKirmizi,
              ),
              child: Text(
                'Randevu Al',
                style: TextStyle(color: Colors.white, fontSize: fontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
