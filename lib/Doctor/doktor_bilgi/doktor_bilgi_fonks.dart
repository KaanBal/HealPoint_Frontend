import 'package:flutter/material.dart';
import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/services/appointments_service.dart';

class DoktorBilgiFonks {
  final AppointmentsService appointmentService = AppointmentsService();

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

  Future<void> createAppointment(Appointments appointment) async {
    try {
      final response =
          await appointmentService.createAppointment(appointment.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Kayıt başarılı: ${response.data}");
      } else {
        print("Kayıt başarısız: ${response.statusMessage}");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
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
