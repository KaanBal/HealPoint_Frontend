import 'package:flutter/material.dart';

class DoktorBilgiFonks {

  void doktorBilgisiGoster(BuildContext context, String doktorAdi) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Doktor Bilgisi'),
        content: Text('$doktorAdi hakkında detaylı bilgi görüntüleniyor.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void randevuAl(BuildContext context, String saat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Randevu Onayı'),
        content: Text('Randevunuz $saat için onaylandı.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  String getNameAndSurname(String name, String surname) {
    String nameSurname = "";

    if (name.isNotEmpty) {
      nameSurname += name;
    }

    if (surname.isNotEmpty) {
      if (nameSurname.isNotEmpty) {
        nameSurname += " ";
      }
      nameSurname += surname;
    }

    return nameSurname;
  }

  void doktorDegerlendir(BuildContext context, String doktorAdi) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$doktorAdi Değerlendir'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Doktoru değerlendirmek için bir yıldız seçin:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Teşekkürler!'),
                        content: Text(
                            'Doktor $doktorAdi için ${index + 1} yıldız verdiniz.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Tamam'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.star_border),
                );
              }),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('İptal'),
          ),
        ],
      ),
    );
  }
}
