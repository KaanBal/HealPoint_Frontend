
import 'package:flutter/material.dart';

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
  String age = '19 yrs';

  // Function to show a dialog for editing information
  void showEditDialog(BuildContext context, String title, String initialValue, ValueChanged<String> onEdit) {
    final TextEditingController controller = TextEditingController(text: initialValue);

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
            child: const Text(
              "İptal",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              onEdit(controller.text);
              Navigator.of(context).pop();
            },
            child: const Text(
              "Kaydet",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
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
                        radius: 65.0,
                        backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/387/387585.png'),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Erza Scarlet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        age, // Upper part displays the updated age
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
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
                      margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                      child: Container(
                        width: 310.0,
                        height: 380.0,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Information",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Divider(color: Colors.black12),
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
                              SizedBox(height: 20.0),
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
                              const SizedBox(height: 20.0),
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
                              const SizedBox(height: 20.0),
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
                              const SizedBox(height: 20.0),
                              buildEditableTile(
                                "Yaş",
                                age,
                                Icons.calendar_today,
                                    (newValue) {
                                  setState(() {
                                    age = newValue;
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
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: 20.0,
            right: 20.0,
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Ad',
                            style: TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                          const SizedBox(height: 5.0),
                          const Text(
                            "Erza",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Soyad',
                            style: TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                          const SizedBox(height: 5.0),
                          const Text(
                            'Scarlet',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    // Removed the "Yaş" field from the bottom section
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for displaying editable fields with an edit button
  Widget buildEditableTile(
      String title, String value, IconData icon, ValueChanged<String> onEdit) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
          size: 35,
        ),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            showEditDialog(context, title, value, onEdit);
          },
        ),
      ],
    );
  }
}
