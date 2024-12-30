import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/services/doctor_service.dart';

class DoktorProfilFonks {
  final DoctorService doctorService = DoctorService();

  Future<Doctors?> loadData() async {
    try {
      final response = await doctorService.getDoctorByToken();
      final Map<String, dynamic> data = response.data;
      return Doctors.fromJson(data);
    } catch (e) {
      print("Hata oluştu: $e");
      return null;
    }
  }

  Future<void> updateDoctor(Doctors doctorData) async {
    try {
      final response = await doctorService.updateDoctorById(doctorData);
      print(response);
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }
}

