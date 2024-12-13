import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HastaProfil extends StatefulWidget {
  const HastaProfil({super.key});

  @override
  HastaProfilState createState() => HastaProfilState();
}

class HastaProfilState extends State<HastaProfil> {
  String phone = '053485932482';
  String email = 'ayberkoz@gmail.com';
  String password = '1234';
  String birthDate = '15/07/2003';

  int calculateAge(String birthDate) {
    DateTime birthDateParsed = DateFormat('dd/MM/yyyy').parse(birthDate);
    DateTime today = DateTime.now();
    int age = today.year - birthDateParsed.year;
    if (today.month < birthDateParsed.month ||
        (today.month == birthDateParsed.month &&
            today.day < birthDateParsed.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final double ekranYuksekligi = MediaQuery.of(context).size.height;
    final double ekranGenisligi = MediaQuery.of(context).size.width;
    int age = calculateAge(birthDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Profil",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white),
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
                      const Text(
                        'Erza Scarlet',
                        style: TextStyle(
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
                      margin: EdgeInsets.only(top: ekranYuksekligi * 0.04,left: ekranGenisligi * 0.1
                          ,right: ekranGenisligi * 0.1),
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
                              phone,
                              Icons.phone,
                                  (newValue) {
                                setState(() {
                                  phone = newValue;
                                });
                              },
                            ),
                            SizedBox(height: ekranYuksekligi * 0.02),
                            buildEditableTile(
                              "E Mail",
                              email,
                              Icons.mail,
                                  (newValue) {
                                setState(() {
                                  email = newValue;
                                });
                              },
                            ),
                            SizedBox(height: ekranYuksekligi * 0.02),
                            buildEditableTile(
                              "Şifre",
                              password,
                              Icons.lock_outline,
                                  (newValue) {
                                setState(() {
                                  password = newValue;
                                });
                              },
                            ),
                            SizedBox(height: ekranYuksekligi * 0.02),
                            buildEditableTile(
                              "Doğum Tarihi",
                              birthDate,
                              Icons.calendar_month,
                                  (newValue) {
                                setState(() {
                                  birthDate = newValue;
                                });
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
                    const Column(
                      children: [
                        Text(
                          'Ad',
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "Erza",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        Text(
                          'Soyad',
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Scarlet',
                          style: TextStyle(
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
                          '$age yrs',
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
