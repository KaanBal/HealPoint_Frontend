import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/services/doctor_service.dart';

class AnaEkranServiceFonks {
  final DoctorService doctorService = DoctorService();

  Future<List<Doctors>> fetchFavDoctors() async {
    try {
      final response = await doctorService.getFavoriteDoctors();
      final List<dynamic> data = response.data;

      return data.map((json) => Doctors.fromJson(json)).toList();
    } catch (e) {
      print("Hata oluştu: $e");
      return [];
    }
  }

    Future<void> removeFavorite(Doctors doctor) async {
    try {
      if (doctor.tc != null) {
        await doctorService.removeFavoriteDoctor(doctor.tc!);
      }
    } catch (e) {
      print(e);
    }
  }
}
