import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doktor Bilgisi'),
        centerTitle: true,
        backgroundColor: acikKirmizi,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doktor Profili ve Bilgiler
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                      'https://media.istockphoto.com/id/1190555653/tr/vekt%C3%B6r/t%C4%B1p-doktoru-profil-simgesi-erkek-doktor-avatar-vekt%C3%B6r-ill%C3%BCstrasyon.jpg?s=170667a&w=0&k=20&c=Jq7BljB3HJND48e8t_JHgRilKtZBr39UZqXeh_SeCYg='), // Doktor fotoğrafı
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. William Anderson',
                      style:
                      TextStyle(fontSize: 21,fontFamily: "ABeeZee" ,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Ürolog',
                      style: TextStyle(fontSize: 19,fontFamily: "PtSans", color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        SizedBox(width: 4),
                        Text('4.7', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Doktor Hakkında Bilgi
            const Text(
              'Doktor Hakkında',
              style: TextStyle(fontSize: 19,fontFamily: "ABeeZee", fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Dr. Anderson is a highly respected and experienced psychiatrist known for his compassionate care and comprehensive approach to mental health. With over 15 years of experience in the field, Dr. Anderson...',
              style: TextStyle(fontSize: 17,fontFamily: "PtSans", color: Colors.black87),
            ),
            const SizedBox(height: 35),

            // Çalışma Saatleri
            const Text(
              'Çalışma Saatleri',
              style: TextStyle(fontSize: 19,fontFamily: "ABeeZee", fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pazartesi - Cuma, 08:00  - 18:00 ',
              style: TextStyle(fontSize: 17,fontFamily: "ABeeZee", color: Colors.black87),
            ),
            const SizedBox(height: 35),

            // Uygun Saatler
            const Text(
              'Uygun Saatler:',
              style: TextStyle(fontSize: 19,fontFamily: "ABeeZee", fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 50),

            // Randevu Al Butonu
            ElevatedButton(
              onPressed: () {
                // Randevu alma işlemi
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(ekranGenisligi, 50),
                backgroundColor: acikKirmizi,
              ),
              child: const Text(
                  'Randevu Al',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}