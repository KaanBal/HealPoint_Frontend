import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/doktor_profil.dart';
import 'package:yazilim_projesi/Doctor/gecmis_randevu/doctor_gecmis_randevu.dart';
import 'package:yazilim_projesi/Doctor/screens/DoctorHomeScreen_fonks.dart';
import 'package:yazilim_projesi/Hasta/yorum/doktor_yorum_ekran%C4%B1.dart';
import 'package:yazilim_projesi/giris_ekran/giris_ekrani.dart';
import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreen();
}

class _DoctorHomeScreen extends State<DoctorHomeScreen> {
  final DoctorHomeScreenFonks fonks = DoctorHomeScreenFonks();
  bool isLoggedOut = false;

  List<Appointments> appointments = [];
  Doctors? doctor;

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Randevular Görüntülenemedi")),
      );
    }
  }

  void _fetchDoctorInfo() async {
    try {
      final doctorInfo = await fonks.loadData();
      setState(() {
        doctor = doctorInfo;
      });
    } catch (e) {
      print("$e");
    }
  }

  Future<void> _cancelAppointment(int id) async {
    try {
      await fonks.cancelAppointment(id);
      setState(() {
        appointments
            .removeWhere((appointment) => appointment.appointmentId == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Randevu başarıyla iptal edildi.")),
      );
    } catch (e) {
      print('Randevu iptal işlemi başarısız oldu. Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hata: Randevu iptal edilemedi.")),
      );
    }
  }

  @override
  void initState() {
    _loadDataFromMockData();
    //_loadData();
    //_fetchDoctorInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontScaleFactor = 0.8;

    return WillPopScope(
      onWillPop: () async {
        if (isLoggedOut) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: beyaz,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Appointments List",
            style: TextStyle(
              fontFamily: "ABeeZee",
              fontSize: screenWidth * 0.05 * fontScaleFactor,
            ),
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Text(
                  'Menü',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06 * fontScaleFactor,
                    fontFamily: "ABeeZee",
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month_outlined),
                title: Text(
                  'Geçmiş Randevular',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045 * fontScaleFactor,
                    fontFamily: "PTSans",
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DoctorPastAppointments()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Profilim',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045 * fontScaleFactor,
                    fontFamily: "PTSans",
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorProfil()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.comment),
                title: Text(
                  'Değerlendirmeler',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045 * fontScaleFactor,
                    fontFamily: "PTSans",
                  ),
                ),
                onTap: () {
                  if (doctor != null && doctor?.tc != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorCommentsScreen(
                            doctorId: doctor!.tc!, doctor: doctor!),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Doktor bilgisi henüz yüklenmedi."),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Çıkış Yap',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045 * fontScaleFactor,
                      fontFamily: "PTSans",
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      isLoggedOut = true;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GirisEkrani()),
                    );
                  }),
            ],
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
                        // Tarih Kutusu
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                              vertical: screenWidth * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            appointment.appointmentDate != null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(appointment.appointmentDate!)
                                : "Tarih Bilgisi Yok",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04 * fontScaleFactor,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // Saat Kutusu
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
                        // Durum Kutusu
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                              vertical: screenWidth * 0.02),
                          decoration: BoxDecoration(
                            color:
                                appointment.getStatusColor().withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            appointment.appointmentStatus
                                .toString()
                                .split('.')
                                .last,
                            style: TextStyle(
                              color: appointment.getStatusColor(),
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04 * fontScaleFactor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Hasta İsmi: ${appointment.patient?.name} ${appointment.patient?.surname}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "ABeeZee",
                        fontSize: screenWidth * 0.045 * fontScaleFactor,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    appointment.appointmentText != null
                        ? Text(
                            "${appointment.appointmentText}",
                            style: TextStyle(
                              fontSize: screenWidth * 0.035 * fontScaleFactor,
                              fontFamily: "PTSans",
                              color: Colors.grey,
                            ),
                          )
                        : const SizedBox(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Randevu İptali"),
                                content: const Text(
                                    "Randevuyu iptal etmek istediğinize emin misiniz?"),
                                actions: [
                                  TextButton(
                                    child: const Text("Hayır"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Evet"),
                                    onPressed: () {
                                      _cancelAppointment(
                                          appointment.appointmentId!);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.cancel,
                            color: Colors.blue, size: 20),
                        label: const Text(
                          "İptal Et",
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
