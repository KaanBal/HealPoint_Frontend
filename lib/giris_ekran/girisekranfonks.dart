import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/screens/Doctor_home_screen.dart';
import 'package:yazilim_projesi/Hasta/ana_ekran/ana_ekran.dart';
import 'package:yazilim_projesi/services/auth_service.dart';

class GirisEkranFonks {
  void showAlertDialog(BuildContext context, String baslik, String mesaj) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(baslik),
          content: Text(mesaj),
          actions: <Widget>[
            TextButton(
              child: const Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void girisYap(
    BuildContext context,
    String username,
    String sifre,
    TextEditingController telefonController,
    TextEditingController sifreController,
    bool isPatient,
    AuthService authService,
  ) async {
    if (username.isNotEmpty && sifre.isNotEmpty) {
      try {
        final response = isPatient
            ? await authService.patientSignIn(username, sifre)
            : await authService.doctorSignIn(username, sifre);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (isPatient) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AnaEkran()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DoctorHomeScreen()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "Hata: ${response.data['message'] ?? 'Giriş başarısız!'}")),
          );
        }
      } catch (e) {
        print("$e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Girdiğiniz bilgiler yanlış!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurun!")),
      );
    }

    telefonController.clear();
    sifreController.clear();
  }

  void kaydol(
    BuildContext context,
    String tc,
    String sifre,
    TextEditingController tcController,
    TextEditingController sifreController,
  ) {
    tcController.clear();
    sifreController.clear();
  }
}
