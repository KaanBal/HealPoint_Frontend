import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/gecmis_randevu/doctorGecmisRandevu_fonks.dart';
import 'package:yazilim_projesi/models/Appointments.dart';

class DoctorPastAppointments extends StatefulWidget {
  const DoctorPastAppointments({super.key});

  @override
  State<DoctorPastAppointments> createState() => _DoctorPastAppointmentsState();
}

class _DoctorPastAppointmentsState extends State<DoctorPastAppointments> {
  final DoctorGecmisRandevuFonks fonks = DoctorGecmisRandevuFonks();

  List<Appointments> pastAppointments = [];
  bool isLoading = true;

  Future<void> _loadData() async {
    try {
      final appointments = await fonks.fetchPastAppointments();
      setState(() {
        pastAppointments = appointments;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata oluştu: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doktor Geçmiş Randevular"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: pastAppointments.length,
                itemBuilder: (context, index) {
                  final pastAppointment = pastAppointments[index];

                  // Randevu tarihi ve saatini string'e dönüştürme
                  final appointmentDate = pastAppointment.appointmentDate;
                  final appointmentTime = pastAppointment.appointmentTime;
                  final dateString =
                      "${appointmentDate?.toLocal().toString().split(' ')[0]}";
                  final timeString = appointmentTime != null
                      ? "${appointmentTime.hour.toString().padLeft(2, '0')}:${appointmentTime.minute.toString().padLeft(2, '0')}"
                      : 'Saat Bilgisi Yok';

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$dateString - $timeString",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Hasta İsmi: ${pastAppointment.patient?.name ?? 'Bilinmiyor'} ${pastAppointment.patient?.surname ?? ''}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Randevu Konusu: ${pastAppointment.appointmentText ?? 'Bilgi Yok'}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: pastAppointment
                                  .getStatusColor()
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              pastAppointment.status ?? 'Durum Bilgisi Yok',
                              style: TextStyle(
                                color: pastAppointment.getStatusColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
