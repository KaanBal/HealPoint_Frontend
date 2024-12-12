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
import 'package:yazilim_projesi/Hasta/yaklasan_randevular/yaklasan_randevular.dart';
import 'package:yazilim_projesi/giris_ekran/giris_ekrani.dart';
import '../Hasta/Hasta_kayit/hasta_kayit_ol.dart';
import 'Doctor/screens/Doctor_home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AbonelikBilgiSayfasi(),
    );
  }
}
