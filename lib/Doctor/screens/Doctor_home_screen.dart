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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontScaleFactor = 0.8; // Font boyutlarını küçültmek için ölçek faktörü

    return Scaffold(
      backgroundColor: beyaz,
      appBar: AppBar(
        backgroundColor: beyaz,
        centerTitle: true,
        title: Text(
          "Appointments List",
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontSize: screenWidth * 0.05 * fontScaleFactor, // Dinamik font boyutu
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            color: beyaz,
            margin: EdgeInsets.all(screenWidth * 0.03), // Dinamik margin
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // Dinamik padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Üst satır: Zaman ve Durum
                  Row(
                    children: [
                      // Appointment Time Chip
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          appointment.appointment_time,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04 * fontScaleFactor, // Dinamik font boyutu
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.02),
                        decoration: BoxDecoration(
                          color: getStatusColor(
                            appointment.Appointment_status
                                .toString()
                                .split('.')
                                .last,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          appointment.Appointment_status
                              .toString()
                              .split('.')
                              .last,
                          style: TextStyle(
                            color: getStatusColor(
                              appointment.Appointment_status
                                  .toString()
                                  .split('.')
                                  .last,
                            ),
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04 * fontScaleFactor, // Dinamik font boyutu
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Hasta İsmi: ${appointment.patient.Patient_name} ${appointment.patient.Patient_surname}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "ABeeZee",
                      fontSize: screenWidth * 0.045 * fontScaleFactor, // Dinamik font boyutu
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "${appointment.Appointment_text}",
                    style: TextStyle(
                      fontSize: screenWidth * 0.035 * fontScaleFactor, // Dinamik font boyutu
                      fontFamily: "PTSans",
                      color: Colors.grey,
                    ),
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