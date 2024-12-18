import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/screens/Doctor_home_screen.dart';
import 'package:yazilim_projesi/Hasta/ana_ekran/ana_ekran.dart';

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
      String telefon,
      String sifre,
      TextEditingController telefonController,
      TextEditingController sifreController,
      bool isHasta,
      ) {
    if (telefon.isNotEmpty && sifre.isNotEmpty) {
      if (telefon == "123" && sifre == "123") {
        if (isHasta) {
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
          const SnackBar(content: Text("Telefon veya şifre hatalı!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurun!")),
      );
      {
        if (telefon.isEmpty || sifre.isEmpty) {
          showAlertDialog(
              context, "Hata", "Telefon numarası ve şifre boş olamaz.");
        } else {
          showAlertDialog(context, "Başarılı", "Giriş yapıldı: $telefon");
          telefonController.clear();
          sifreController.clear();
        }
        telefonController.clear();
        sifreController.clear();
      }
    }
  }

  void kaydol(
      BuildContext context,
      String telefon,
      String sifre,
      TextEditingController telefonController,
      TextEditingController sifreController,
      ) {
    if (telefon.isEmpty || sifre.isEmpty) {
      showAlertDialog(context, "Hata", "Telefon numarası ve şifre boş olamaz.");
    } else {
      showAlertDialog(context, "Başarılı", "Kayıt yapıldı: $telefon");
      telefonController.clear();
      sifreController.clear();
    }
  }
}


