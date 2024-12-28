import 'package:flutter/material.dart';
import 'package:yazilim_projesi/giris_ekran/giris_ekrani.dart';

import 'models/Doctors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Doctors> exampleDoctors = [
      Doctors(
        name: "Dr. Ahmet Yılmaz",
        branch: "Kardiyoloji",
        surname: 'adigu',
      ),
      Doctors(
        name: "Dr. Elif Kaya",
        branch: "Dermatoloji",
        surname: 'kagabu',
      ),
      Doctors(
        name: "Dr. Mehmet Kaya",
        branch: "Dermatoloji",
        surname: 'kagabu',
      ),
      Doctors(
        name: "Dr. Şahmet Kaya",
        branch: "Dermatoloji",
        surname: 'kagabu',
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GirisEkrani(),
    );
  }
}
