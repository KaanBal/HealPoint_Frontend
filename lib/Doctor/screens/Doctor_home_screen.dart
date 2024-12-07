import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yazilim_projesi/models/Appointments.dart';

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
        appBar: AppBar(
          title: const Text("Appoinments List"),
        ),
        body: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  "Hasta İsmi: ${appointment.patient.Patient_name
                      + " "
                      + appointment.patient.Patient_surname}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.appointment_time),
                    Text(appointment.Appointment_status.toString().split('.').last),
                    Text("${appointment.Appointment_text}"),
                  ],
                ),
                leading: const Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            );
          },
        ));
  }
}
