import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/Doctor/doktor_bilgi/doktor_bilgi.dart';
import 'package:yazilim_projesi/Doctor/favori_doktor/favori_doktor.dart';
import 'package:yazilim_projesi/Hasta/HastaProfil/hasta_profil.dart';
import 'package:yazilim_projesi/Hasta/ana_ekran/anaEkranService_fonks.dart';
import 'package:yazilim_projesi/Hasta/gecmisRandevu/gecmis_randevu.dart';
import 'package:yazilim_projesi/Hasta/randevu_al/randevu_al.dart';
import 'package:yazilim_projesi/Hasta/yaklasan_randevular/yaklasan_randevular.dart';
import 'package:yazilim_projesi/giris_ekran/giris_ekrani.dart';
import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';
import 'package:yazilim_projesi/services/appointments_service.dart';
import 'package:yazilim_projesi/services/doctor_service.dart';
import 'package:yazilim_projesi/services/patient_service.dart';
import 'anaekranfonk.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DoctorService doctorService = DoctorService();
  final AppointmentsService appointmentsService = AppointmentsService();
  final PatientService patientService = PatientService();

  final AnaEkranServiceFonks serviceFonks = AnaEkranServiceFonks();

  bool isLoggedOut = false;

  List<Doctors> doctors = [];
  List<Doctors> favDoctors = [];
  List<Appointments> upcomingAppointments = [];
  String? patientName;

  void _loadDataFromMockData() async {
    const String doctorsJsonFile = 'assets/MockData/doctors.json';
    const String appointmentsJsonFile = 'assets/MockData/appointments.json';

    try {
      final doctorsDataString = await rootBundle.loadString(doctorsJsonFile);
      final List<dynamic> doctorsJsonData = json.decode(doctorsDataString);

      final appointmentsDataString =
          await rootBundle.loadString(appointmentsJsonFile);
      final List<dynamic> appointmentsJsonData =
          json.decode(appointmentsDataString);

      setState(() {
        doctors =
            doctorsJsonData.map((data) => Doctors.fromJson(data)).toList();
        upcomingAppointments = appointmentsJsonData
            .map((data) => Appointments.fromJson(data))
            .toList();
      });
    } catch (e) {
      print('Error loading mock data: $e');
    }
  }

  Future<void> _loadPatientName() async {
    try {
      final response = await patientService.getPatientName();
      setState(() {
        patientName = response.data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kullanıcı bilgileri alınamadı: $e")),
      );
    }
  }

  Future<void> _loadData() async {
    try {
      final response = await doctorService.fetchAllDoctors();
      final List<dynamic> data = response.data;

      setState(() {
        doctors =
            data.map((doctorJson) => Doctors.fromJson(doctorJson)).toList();
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Doktorlar Görüntülenemedi")),
      );
    }
  }

  Future<void> _loadUpcomingAppointments() async {
    try {
      final response = await appointmentsService.fetchUpcomingAppointments();
      final List<dynamic> data = response.data;

      setState(() {
        upcomingAppointments = data
            .map((appointmentJson) => Appointments.fromJson(appointmentJson))
            .toList();
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Yaklaşan Randevular Görüntülenemedi")),
      );
    }
  }

  Future<void> _getFavoritesDoctor() async {
    try {
      favDoctors = await serviceFonks.fetchFavDoctors();
      setState(() {});
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Favori Doktorlar Görüntülenemedi")),
      );
    }
  }

  Future<void> _saveFavoriteDoctor(Doctors doctor) async {
    try {
      if (doctor.tc != null) {
        await doctorService.addFavoriteDoctor(doctor.tc!);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Doktor Favorileri Eklenemedi")),
      );
    }
  }

  Future<void> _removeFavorite(Doctors doctor) async {
    try {
      print('Favori doktor silme işlemi başladı. Doktor: ${doctor.tc}');
      await serviceFonks.removeFavorite(doctor);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Doktor favorilerden kaldırıldı.")),
      );
    } catch (e) {
      print('Favori doktor silme işlemi başarısız oldu. Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Hata: Doktor favorilerden kaldırılamadı.")),
      );
    }
  }

  Future<void> _toggleFavoriteDoctor(Doctors doctor) async {
    try {
      if (favDoctors.any((favDoctor) => favDoctor.tc == doctor.tc)) {
        await _removeFavorite(doctor);
        setState(() {
          favDoctors.removeWhere((favDoctor) => favDoctor.tc == doctor.tc);
        });
      } else {
        await _saveFavoriteDoctor(doctor);
        setState(() {
          favDoctors.add(doctor);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    //_loadDataFromMockData();
    _loadData();
    _loadPatientName();
    _loadUpcomingAppointments();
    _getFavoritesDoctor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.05;
    double avatarRadius = screenWidth * 0.1;
    double buttonPadding = screenWidth * 0.05;

    return WillPopScope(
      onWillPop: () async {
        if (isLoggedOut) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: beyaz,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: acikKirmizi,
                ),
                child: Text(
                  'Sağlıklı Günler',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month_outlined),
                title: const Text('Geçmiş Randevular'),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GecmisRandevular()))
                      .then((_) {
                    _loadData();
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profilim'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HastaProfil()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite_border),
                title: const Text(
                  'Favori Doktorlarım',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteDoctorsPage(),
                    ),
                  ).then((_) {
                    _getFavoritesDoctor();
                  });
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Çıkış Yap',
                  style: TextStyle(color: Colors.red),
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
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 50.0, right: 16.0, left: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Selam $patientName ',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: "ABeeZee",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    child: Image.asset(
                      'resimler/menu.png',
                      width: screenWidth * 0.08,
                      height: screenHeight * 0.08,
                    ),
                  ),
                ],
              ),
              Text(
                "Sağlıklı Günler",
                style: TextStyle(
                  fontSize: fontSize * 0.8,
                  fontFamily: "PtSans",
                  color: gri,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RandevuAl())).then((_) {
                    _loadUpcomingAppointments();
                    _getFavoritesDoctor();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: acikKirmizi,
                  foregroundColor: beyaz,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: buttonPadding,
                    vertical: screenHeight * 0.015,
                  ),
                ),
                child: const Text(
                  "Randevu Al",
                  style: TextStyle(fontFamily: "ABeeZee"),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Yaklaşan Randevular",
                    style: TextStyle(
                      fontFamily: "ABeeZee",
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YaklasanRandevular(
                                      appointments: upcomingAppointments)))
                          .then((_) {
                        _loadUpcomingAppointments();
                      });
                    },
                    child: Text(
                      " Görüntüle",
                      style: TextStyle(
                        fontFamily: "ABeeZee",
                        fontWeight: FontWeight.normal,
                        fontSize: fontSize * 0.6,
                        color: acikKirmizi,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              if (upcomingAppointments.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: beyaz,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: acikGri.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: AssetImage('resimler/doktor.png'),
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            'resimler/doktor.png',
                            fit: BoxFit.cover, // Resmin sığması için
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            upcomingAppointments[0].doctor?.name ??
                                "Doktor Bilgisi Yok",
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: "PtSans",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            upcomingAppointments[0].appointmentDate != null
                                ? DateFormat('dd MMMM yyyy').format(
                                    upcomingAppointments[0].appointmentDate!)
                                : "Tarih Bilgisi Yok",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "PtSans",
                              color: gri,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            children: [
                              Image.asset(
                                'resimler/calendar.png',
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Text(
                                upcomingAppointments[0].appointmentTime != null
                                    ? '${upcomingAppointments[0].appointmentTime!.hour.toString().padLeft(2, '0')}:${upcomingAppointments[0].appointmentTime!.minute.toString().padLeft(2, '0')}'
                                    : "Saat Bilgisi Yok",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "PtSans",
                                  color: gri,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                Center(
                  child: Text(
                    "Henüz bir yaklaşan randevunuz yok.",
                    style: TextStyle(
                      fontSize: fontSize * 0.8,
                      fontFamily: "PtSans",
                      color: gri,
                    ),
                  ),
                ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Tüm Doktorlar',
                style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: "ABeeZee",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.01),
              Expanded(
                child: ListView.separated(
                  itemCount: doctors.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: screenHeight * 0.015),
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    // Favori durumu kontrolü
                    final isFavorite = favDoctors
                        .any((favDoctor) => favDoctor.tc == doctor.tc);

                    return InkWell(
                      onTap: () {
                        if (doctor.tc != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DoctorBilgiEkran(doctorId: doctor.tc!),
                            ),
                          ).then((_) {
                            _loadUpcomingAppointments();
                            _getFavoritesDoctor();
                          });
                        }
                      },
                      child: DoctorCard(
                        name: doctor.name ?? "",
                        specialization: doctor.branch ?? "",
                        rating: doctor.avgPoint.toString(),
                        favourite: isFavorite,
                        onFavoriteTap: () {
                          _toggleFavoriteDoctor(doctor);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
