import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreen();
}

class _DoctorHomeScreen extends State<DoctorHomeScreen> {
  List<Appointments> appointments = [];

  void _loadData() async {
    const String jsonFile = 'assets/MockData/appointments.json';
    final dataString = await rootBundle.loadString(jsonFile);
    final List<dynamic> dataJson = jsonDecode(dataString);

    appointments = dataJson.map((json) => Appointments.fromJson(json)).toList();

    setState(() {});
  }


  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beyaz,
      appBar: AppBar(
        backgroundColor: beyaz,
        centerTitle: true,
        title: const Text(
            "Appointments List",
          style: TextStyle(fontFamily: "ABeeZee"),
        ),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            color: beyaz,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Üst satır: Zaman ve Durum
                  Row(
                    children: [
                      // Appointment Time Chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          appointment.appointment_time,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: getStatusColor(
                            appointment.Appointment_status.toString().split('.').last,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          appointment.Appointment_status.toString().split('.').last,
                          style: TextStyle(
                            color: getStatusColor(
                              appointment.Appointment_status.toString().split('.').last,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Hasta İsmi: ${appointment.patient.Patient_name} ${appointment.patient.Patient_surname}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,fontFamily: "ABeeZee", fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${appointment.Appointment_text}",
                    style: const TextStyle(fontSize: 14,fontFamily: "PTSans" ,color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "AKTIF":
        return Colors.green;
      case "IPTAL":
        return Colors.red;
      default:
        return Colors.blue; 
    }
  }
}
