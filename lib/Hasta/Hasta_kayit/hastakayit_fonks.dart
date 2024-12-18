import 'package:flutter/material.dart';
import 'package:yazilim_projesi/services/auth_service.dart';

class HastakayitFonks {
  final AuthService _authService = AuthService();

  Future<void> kayitOl({
    required String tc,
    required String telefon,
    required String isim,
    required String soyisim,
    required String sifre,
    required String email,
    required String dogumTarihi,
    required String cinsiyet,
  }) async {
    try {
      Map<String, dynamic> patientData = {
        "tc": tc,
        "telefon": telefon,
        "isim": isim,
        "soyisim": soyisim,
        "sifre": sifre,
        "email": email,
        "dogumTarihi": dogumTarihi,
        "cinsiyet": cinsiyet,
      };

      final response = await _authService.patientSignUp(patientData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Kayıt başarılı: ${response.data}");
      } else {
        print("Kayıt başarısız: ${response.statusMessage}");
      }
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }
}
