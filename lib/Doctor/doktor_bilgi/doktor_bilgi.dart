import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yazilim_projesi/Doctor/doktor_bilgi/doktor_bilgi_fonks.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class DoctorBilgiEkran extends StatefulWidget {
  const DoctorBilgiEkran({super.key});

  @override
  State<DoctorBilgiEkran> createState() => _DoctorBilgiEkran();
}

class _DoctorBilgiEkran extends State<DoctorBilgiEkran> {
  Doctors? selectedDoctor;

  void _loadData() async {
    const String jsonFile = 'assets/MockData/doctorInfo.json';
    final dataString = await rootBundle.loadString(jsonFile);
    final Map<String, dynamic> jsonData = json.decode(dataString);
    selectedDoctor = Doctors.fromJson(jsonData);
    setState(() {});
  }

  void _showBottomSheet(BuildContext context) {
    DateTime? selectedDate;
    String? selectedTime;
    List<String> availableTimes = [];

    void selectDate(StateSetter bottomSheetSetState) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2025),
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        bottomSheetSetState(() {
          selectedDate = pickedDate;
          availableTimes = ['08:00', '10:00', '12:00'];
          selectedTime = availableTimes[0];
        });
      }
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter bottomSheetSetState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Uygun Tarih ve Saat Seçimi',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "ABeeZee"),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tarih Seçimi',
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "ABeeZee"),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => selectDate(bottomSheetSetState),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: acikKirmizi,
                                foregroundColor: beyaz,
                              ),
                              child: const Text("Tarih Seç"),
                            ),
                            if (selectedDate != null && selectedTime != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Seçilen Tarih ve Saat: ${selectedDate!.toLocal().toString().split(' ')[0]} / $selectedTime',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      if (availableTimes.isNotEmpty)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Uygun Saatler',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: "ABeeZee"),
                              ),
                              const SizedBox(height: 10),
                              DropdownButton<String>(
                                hint: const Text("Saat Seçin"),
                                value: selectedTime,
                                onChanged: (String? newValue) {
                                  bottomSheetSetState(() {
                                    selectedTime = newValue;
                                  });
                                },
                                items: availableTimes.map((String time) {
                                  return DropdownMenuItem<String>(
                                    value: time,
                                    child: Text(time),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: acikKirmizi,
                      ),
                      child: const Text(
                        'Onayla',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final DoktorBilgiFonks doktorBilgiFonks = DoktorBilgiFonks();

    double fontSize = ekranGenisligi / 22;
    double padding = ekranGenisligi * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doktor Bilgisi',
          style: TextStyle(fontFamily: "ABeeZee", color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: acikKirmizi,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: ekranGenisligi * 0.04),
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('resimler/doktor.png'),
                      ),
                      SizedBox(width: ekranGenisligi * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: ekranYuksekligi * 0.02),
                          Text(
                            selectedDoctor?.name ?? "",
                            style: const TextStyle(
                                fontSize: 19,
                                fontFamily: "ABeeZee",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            selectedDoctor?.branch ?? "",
                            style: const TextStyle(
                                fontSize: 17,
                                fontFamily: "PtSans",
                                color: Colors.grey),
                          ),
                          SizedBox(height: ekranYuksekligi * 0.01),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.yellow, size: 18),
                              const SizedBox(width: 5),
                              Text(
                                  selectedDoctor?.reviews?.first.points
                                          .toString() ??
                                      "0",
                                  style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                          SizedBox(height: ekranYuksekligi * 0.01),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      print("Resim tıklandı!");
                    },
                    child: Image.asset(
                      'resimler/click.png',
                      width: 25,
                      height: 30,
                      color: acikKirmizi,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ekranYuksekligi * 0.04),
            Text(
              'Doktor Hakkında',
              style: TextStyle(
                  fontSize: fontSize * 1.1,
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: ekranYuksekligi * 0.02),
            Text(
              selectedDoctor?.about ?? "",
              style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: "PtSans",
                  color: Colors.black87),
            ),
            SizedBox(height: ekranYuksekligi * 0.04),
            Text(
              'Çalışma Saatleri',
              style: TextStyle(
                  fontSize: fontSize * 1.1,
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: ekranYuksekligi * 0.02),
            Text(
              'Pazartesi - Cuma, 08:00  - 18:00 ',
              style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: "ABeeZee",
                  color: Colors.black87),
            ),
            SizedBox(height: ekranYuksekligi * 0.04),
            Text(
              'Yorumlar',
              style: TextStyle(
                  fontSize: fontSize * 1.1,
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: ekranYuksekligi * 0.02),
            SizedBox(
              height: ekranYuksekligi * 0.25,
              child: selectedDoctor?.reviews != null
                  ? ListView.builder(
                      itemCount: selectedDoctor?.reviews?.length,
                      itemBuilder: (context, index) {
                        final review = selectedDoctor!.reviews![index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: padding / 2),
                          child: Padding(
                            padding: EdgeInsets.all(padding / 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doktorBilgiFonks.getNameAndSurname(
                                      review.patient?.name ?? "",
                                      review.patient?.surname ?? ""),
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "ABeeZee"),
                                ),
                                SizedBox(height: ekranYuksekligi * 0.01),
                                Text(
                                  review.comment ?? "",
                                  style: TextStyle(
                                      fontSize: fontSize * 0.9,
                                      fontFamily: "PtSans",
                                      color: Colors.black87),
                                ),
                                SizedBox(height: ekranYuksekligi * 0.01),
                                Text(
                                  review.createdAt?.toIso8601String() ?? "",
                                  style: TextStyle(
                                      fontSize: fontSize * 0.8,
                                      fontFamily: "PtSans",
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No reviews available",
                        style: TextStyle(
                          fontSize: fontSize * 0.9,
                          fontFamily: "PtSans",
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: ekranYuksekligi * 0.07),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: acikKirmizi,
                  foregroundColor: beyaz,
                ),
                child: Text(
                  "Randevu Al",
                  style: TextStyle(
                    fontSize: fontSize * 1.1,
                    fontFamily: "ABeeZee",
                  ),
                ),
              ),
            ),
            SizedBox(height: ekranYuksekligi * 0.04),
          ],
        ),
      ),
    );
  }
}
