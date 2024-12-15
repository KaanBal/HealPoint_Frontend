import 'api_client.dart';
import 'package:http/http.dart' as http;

class DoctorService {
  final ApiClient _apiClient = ApiClient();

  Future<http.Response> fetchDoctorList() async {
    return await _apiClient.get('doctors/list');
  }

  Future<http.Response> saveDoctor(Map<String, dynamic> doctorData) async {
    return await _apiClient.post('doctors/save', doctorData);
  }
}
