import 'package:intl/intl.dart';
import 'package:yazilim_projesi/services/auth_service.dart';

class HastakayitFonks {
  final AuthService _authService = AuthService();

  Future<void> kayitOl({
    required String tc,
    required String phoneNumber,
    required String name,
    required String surname,
    required String password,
    required String email,
    required String birthDate, 
    required String gender,
  }) async {
    try {
      String formattedBirthDate = _formatDateToBackend(birthDate);

      Map<String, dynamic> patientData = {
        "tc": tc,
        "phoneNumber": phoneNumber,
        "name": name,
        "surname": surname,
        "password": password,
        "email": email,
        "birthDate": formattedBirthDate, 
        "gender": gender,
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

  String _formatDateToBackend(String birthDate) {
    try {
      DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(birthDate);

      return DateFormat("yyyy-MM-dd").format(parsedDate);
    } catch (e) {
      print("Tarih formatlama hatası: $e");
      return birthDate; 
    }
  }
}
