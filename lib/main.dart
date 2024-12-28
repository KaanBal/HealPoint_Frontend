import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/doktor_abonelik.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/doktor_profil.dart';
import 'package:yazilim_projesi/Doctor/doktor_bilgi/doktor_bilgi.dart';
import 'package:yazilim_projesi/Doctor/favori_doktor/favori_doktor.dart';
import 'package:yazilim_projesi/Doctor/screens/Doctor_home_screen.dart';
import 'package:yazilim_projesi/Hasta/ana_ekran/ana_ekran.dart';
import 'package:yazilim_projesi/Hasta/gecmisRandevu/gecmis_randevu.dart';
import 'package:yazilim_projesi/Hasta/randevu_al/randevu_al.dart';
import 'package:yazilim_projesi/Hasta/randevu_al/randevu_al_doktor_liste.dart';
import 'package:yazilim_projesi/Hasta/yorum/doktor_yorum_ekran%C4%B1.dart';
import 'package:yazilim_projesi/Hasta/yorum/hasta_yorum.dart';
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
      home: const AnaEkran(),
    );
  }
}
