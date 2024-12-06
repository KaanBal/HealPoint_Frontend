import 'package:flutter/material.dart';
import 'package:yazilim_projesi/ana_ekran/ana_ekran.dart';
import 'package:yazilim_projesi/giris_ekran/giris_ekrani.dart';

import 'doktor_bilgi/doktor_bilgi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ayberk1",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DoctorInfoScreen(),

    );
  }
}
