import 'package:flutter/material.dart';

class GirisEkranFonks {
  int a;

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

  void girisYap(BuildContext context, String telefon, String sifre,
      TextEditingController telefonController, TextEditingController sifreController) {
    if (telefon.isEmpty || sifre.isEmpty) {
      showAlertDialog(context, "Hata", "Telefon numarası ve şifre boş olamaz.");
    } else {
      showAlertDialog(context, "Başarılı", "Giriş yapıldı: $telefon");

      telefonController.clear();
      sifreController.clear();
    }
  }

  void kaydol(BuildContext context, String telefon, String sifre,
      TextEditingController telefonController, TextEditingController sifreController) {
    if (telefon.isEmpty || sifre.isEmpty) {
      showAlertDialog(context, "Hata", "Telefon numarası ve şifre boş olamaz.");
    } else {
      showAlertDialog(context, "Başarılı", "Kayıt yapıldı: $telefon");

      telefonController.clear();
      sifreController.clear();
    }
  }

}
