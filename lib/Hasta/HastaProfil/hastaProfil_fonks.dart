import 'package:yazilim_projesi/models/Patients.dart';
import 'package:yazilim_projesi/services/patient_service.dart';

class HastaProfilFonks {
  final PatientService patientService = PatientService();

  Future<Patients?> loadData() async {
    try {
      final response = await patientService.getPatientById();
      final Map<String, dynamic> data = response.data;
      final patient = Patients.fromJson(data);
      return patient;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
