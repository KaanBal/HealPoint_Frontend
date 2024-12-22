import 'package:flutter/material.dart';

class Patient {
  final String? patientName;
  final String? patientSurname;

  Patient({this.patientName, this.patientSurname});
}

class Appointment {
  final DateTime? appointmentDate;
  final TimeOfDay? appointmentTime;
  final Patient? patient;
  final String? appointmentText;

  Appointment({
    this.appointmentDate,
    this.appointmentTime,
    this.patient,
    this.appointmentText,
  });
}

class DoctorPastAppointments extends StatefulWidget {
  const DoctorPastAppointments({super.key});

  @override
  State<DoctorPastAppointments> createState() => _DoctorPastAppointmentsState();
}

class _DoctorPastAppointmentsState extends State<DoctorPastAppointments> {
  List<Appointment> pastAppointments = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Geçmiş randevuları manuel olarak ekliyoruz
  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    // Örnek randevular
    pastAppointments = [
      Appointment(
        appointmentDate: DateTime(2023, 12, 20),
        appointmentTime: TimeOfDay(hour: 10, minute: 30),
        patient: Patient(patientName: 'Ahmet', patientSurname: 'Yılmaz'),
        appointmentText: 'Diş tedavisi',
      ),
      Appointment(
        appointmentDate: DateTime(2023, 12, 19),
        appointmentTime: TimeOfDay(hour: 14, minute: 0),
        patient: Patient(patientName: 'Ayşe', patientSurname: 'Kara'),
        appointmentText: 'Ağrı tedavisi',
      ),
      Appointment(
        appointmentDate: DateTime(2023, 12, 18),
        appointmentTime: TimeOfDay(hour: 9, minute: 0),
        patient: Patient(patientName: 'Mehmet', patientSurname: 'Öztürk'),
        appointmentText: 'Kontrol',
      ),
    ];

    // Randevuları tarihe göre sıralıyoruz (en yeni önce)
    pastAppointments.sort((a, b) => b.appointmentDate!.compareTo(a.appointmentDate!));

    setState(() {
      isLoading = false;
    });
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
            final dateString = "${appointmentDate?.toLocal().toString().split(' ')[0]}";
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
                      "Hasta İsmi: ${pastAppointment.patient?.patientName ?? 'Bilinmiyor'} ${pastAppointment.patient?.patientSurname ?? ''}",
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
