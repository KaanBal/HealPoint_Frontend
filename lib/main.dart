import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/abone_ol.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/abonelik_onaylama.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/doktor_abonelik.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/doktor_profil.dart';
import 'package:yazilim_projesi/Doctor/Doktor_kayit/doktor_kayit_ol.dart';
import 'package:yazilim_projesi/Doctor/doktor_bilgi/doktor_bilgi.dart';
import 'package:yazilim_projesi/Doctor/doktor_bilgi/hasta_doktorprofil_goruntuler.dart';
import 'package:yazilim_projesi/Hasta/HastaProfil/hasta_profil.dart';
import 'package:yazilim_projesi/Hasta/ana_ekran/ana_ekran.dart';
import 'package:yazilim_projesi/Doctor/doktor_bilgi/doktor_bilgi_fonks.dart';
import 'package:yazilim_projesi/Hasta//gecmisRandevu/gecmis_randevu.dart';
import 'package:yazilim_projesi/Hasta/randevu_al/randevu_al.dart';
import 'package:yazilim_projesi/Hasta/randevu_al/randevu_al_doktor_liste.dart';
import 'package:yazilim_projesi/Hasta/yaklasan_randevular/yaklasan_randevular.dart';
import 'package:yazilim_projesi/giris_ekran/giris_ekrani.dart';
import '../Hasta/Hasta_kayit/hasta_kayit_ol.dart';
import 'Doctor/screens/Doctor_home_screen.dart';
import 'package:yazilim_projesi/Hasta/randevu_al/randevu_al_doktor_liste.dart';

import 'models/Doctors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek doktor listesini burada tanımlıyoruz
    List<Doctors> exampleDoctors = [
      Doctors(
        Doctor_name: "Dr. Ahmet Yılmaz",
        branch: "Kardiyoloji",
        reviews: [
        ], Doctor_tc: '12345678913', Doctor_surname: 'adigu',
      ),
      Doctors(
        Doctor_name: "Dr. Elif Kaya",
        branch: "Dermatoloji",
        reviews: [
        ], Doctor_tc: '12345678911', Doctor_surname: 'kagabu',
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FilteredDoctorsScreen(filteredDoctors: exampleDoctors),
    );
  }
}
