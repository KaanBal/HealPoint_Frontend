import 'package:yazilim_projesi/services/auth_service.dart';

class DoktorkayitolFonks {
  final AuthService _authService = AuthService();

  Future<void> kayitOl(Map<String, dynamic> doctorJson) async {
    try {
      final response = await _authService.doctorSignUp(doctorJson);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Kayıt başarılı: ${response.data}");
      } else {
        print("Kayıt başarısız: ${response.statusMessage}");
      }
    } catch (e) {
      print("Hata oluştu: $e");
      rethrow;
    }
  }
}
