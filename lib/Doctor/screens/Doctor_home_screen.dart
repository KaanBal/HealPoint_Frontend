import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yazilim_projesi/Doctor/screens/DoctorHomeScreen_fonks.dart';
import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreen();
}

class _DoctorHomeScreen extends State<DoctorHomeScreen> {
  final DoctorHomeScreenFonks fonks = DoctorHomeScreenFonks();

  List<Appointments> appointments = [];

  void _loadDataFromMockData() async {
    const String jsonFile = 'assets/MockData/appointments.json';
    final dataString = await rootBundle.loadString(jsonFile);
    final List<dynamic> dataJson = jsonDecode(dataString);

    appointments = dataJson.map((json) => Appointments.fromJson(json)).toList();

    setState(() {});
  }

  void _loadData() async {
    try {
      appointments = await fonks.fetchAppointments();
      setState(() {});
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  @override
  void initState() {
    _loadDataFromMockData();
    //_loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontScaleFactor = 0.8;

    return Scaffold(
      backgroundColor: beyaz,
      appBar: AppBar(
        backgroundColor: beyaz,
        centerTitle: true,
        title: Text(
          "Appointments List",
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontSize: screenWidth * 0.05 * fontScaleFactor,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            color: beyaz,
            margin: EdgeInsets.all(screenWidth * 0.03),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          appointment.appointmentTime != null
                              ? '${appointment.appointmentTime!.hour.toString().padLeft(2, '0')}:${appointment.appointmentTime!.minute.toString().padLeft(2, '0')}'
                              : "Saat Bilgisi Yok",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04 * fontScaleFactor,
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
                            appointment.appointmentStatus
                                .toString()
                                .split('.')
                                .last,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          appointment.appointmentStatus
                              .toString()
                              .split('.')
                              .last,
                          style: TextStyle(
                            color: getStatusColor(
                              appointment.appointmentStatus
                                  .toString()
                                  .split('.')
                                  .last,
                            ),
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04 * fontScaleFactor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Hasta İsmi: ${appointment.patient?.patientName} ${appointment.patient?.patientSurname}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "ABeeZee",
                      fontSize: screenWidth * 0.045 * fontScaleFactor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "${appointment.appointmentText}",
                    style: TextStyle(
                      fontSize: screenWidth * 0.035 * fontScaleFactor,
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
