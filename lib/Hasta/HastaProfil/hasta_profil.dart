import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/Hasta/HastaProfil/hastaProfil_fonks.dart';
import 'package:yazilim_projesi/models/Patients.dart';

class HastaProfil extends StatefulWidget {
  const HastaProfil({super.key});

  @override
  HastaProfilState createState() => HastaProfilState();
}

class HastaProfilState extends State<HastaProfil> {
  final HastaProfilFonks fonks = HastaProfilFonks();

  Patients? patient;

  void _loadData() async {
    try {
      patient = await fonks.loadData();
      setState(() {});
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  Future<void> _updatePatientData() async {
    if (patient != null) {
      try {
        await fonks.updatePatient(patient!);
        debugPrint("Doctor data updated successfully.");
      } catch (e) {
        debugPrint("Error updating doctor data: $e");
      }
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    _updatePatientData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double ekranYuksekligi = MediaQuery.of(context).size.height;
    final double ekranGenisligi = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: ekranGenisligi * 0.15,
                        backgroundImage: const NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/387/387585.png'),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(height: ekranYuksekligi * 0.015),
                      Text(
                        patient?.name ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Card(
                      color: Colors.grey[200],
                      margin: EdgeInsets.only(
                          top: ekranYuksekligi * 0.04,
                          left: ekranGenisligi * 0.1,
                          right: ekranGenisligi * 0.1),
                      child: Padding(
                        padding: EdgeInsets.all(ekranGenisligi * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Bilgiler",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Divider(color: Colors.black12),
                            buildEditableTile(
                              "Telefon No",
                              patient?.phoneNumber ??
                                  "Telefon Numarası Bulunamadı",
                              Icons.phone,
                              (newValue) {
                                setState(() {
                                  patient?.phoneNumber = newValue;
                                });
                              },
                            ),
                            SizedBox(height: ekranYuksekligi * 0.02),
                            buildEditableTile(
                              "E Mail",
                              patient?.email ?? "Email bulunamadı",
                              Icons.mail,
                              (newValue) {
                                setState(() {
                                  patient?.email = newValue;
                                });
                              },
                            ),
                            SizedBox(height: ekranYuksekligi * 0.02),
                            buildEditableTile(
                              "Şifre",
                              patient?.password ?? "",
                              Icons.lock_outline,
                              (newValue) {
                                setState(() {
                                  patient?.password = newValue;
                                });
                              },
                            ),
                            SizedBox(height: ekranYuksekligi * 0.02),
                            buildEditableTile(
                              "Doğum Tarihi",
                              patient?.birthDate != null
                                  ? DateFormat('dd/MM/yyyy')
                                      .format(patient!.birthDate!)
                                  : "",
                              Icons.calendar_month,
                              (newValue) async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      patient?.birthDate ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    patient?.birthDate = pickedDate;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: ekranYuksekligi * 0.30,
            left: ekranGenisligi * 0.09,
            right: ekranGenisligi * 0.09,
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ekranYuksekligi * 0.01,
                  horizontal: ekranGenisligi * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Ad',
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          patient?.name ?? "",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Soyad',
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          patient?.surname ?? "",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Yaş',
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          '${patient?.age ?? "Unknown"} yrs',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableTile(
      String title, String value, IconData icon, ValueChanged<String> onEdit) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
          size: 30,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 13.0),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            showEditDialog(context, title, value, onEdit);
          },
        ),
      ],
    );
  }

  void showEditDialog(BuildContext context, String title, String initialValue,
      ValueChanged<String> onEdit) {
    final TextEditingController controller =
        TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Düzenle: $title"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Yeni $title girin"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("İptal"),
          ),
          TextButton(
            onPressed: () {
              onEdit(controller.text);
              Navigator.of(context).pop();
            },
            child: const Text("Kaydet"),
          ),
        ],
      ),
    );
  }
}
