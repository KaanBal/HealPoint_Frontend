import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/doktor_abonelik.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

// Global showEditDialog function
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

class DoctorProfil extends StatefulWidget {
  const DoctorProfil({super.key});

  @override
  State<DoctorProfil> createState() => _DoctorProfilState();
}

class _DoctorProfilState extends State<DoctorProfil> {
  String city = "Adana";
  String district = "Sarıçam";
  String address = "156.sokak ahmetağa mah.";
  String phone = "+62 812345678";
  String email = "aseps.career@gmail.com";
  String sifre = "1234";
  String about =
      "Dr. Anderson is a highly respected and experienced psychiatrist known for his compassionate care and comprehensive approach to mental health. With over 15 years of experience in the field, Dr. Anderson...";

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Font size scaling factor (80% of original size)
    double fontScaleFactor = 0.8;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: beyaz,
        appBar: AppBar(
          backgroundColor: acikKirmizi,
          titleTextStyle: const TextStyle(
            color: Colors.white,
          ),
          toolbarHeight: screenHeight * 0.35, // Adjust toolbar height
          title: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05),
            child: Column(
              children: [
                profilePhotos(fontScaleFactor),
                profileName(fontScaleFactor),
                hobbies(fontScaleFactor),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            indicatorColor: siyah,
            labelColor: siyah,
            unselectedLabelColor: beyaz,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(
                text: "Hakkında",
                icon: Icon(Icons.account_box),
              ),
              Tab(
                text: "Bilgiler",
                icon: Icon(Icons.contact_page),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: AboutSection(
                aboutText: about,
                onEdit: (newValue) {
                  setState(() {
                    about = newValue;
                  });
                },
                fontScaleFactor: fontScaleFactor,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  contactDetail(screenWidth, fontScaleFactor),
                  contactStatus(screenWidth, fontScaleFactor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding hobbies(double fontScaleFactor) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Text(
        "Ürolog",
        style: TextStyle(
          fontFamily: "ABeeZee",
          fontWeight: FontWeight.normal,
          fontSize: MediaQuery.of(context).size.width * 0.04 * fontScaleFactor, // Dynamically adjusting font size
        ),
      ),
    );
  }

  Padding profileName(double fontScaleFactor) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          "Dr. William Anderson",
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontSize: MediaQuery.of(context).size.width * 0.045 * fontScaleFactor, // Dynamically adjusting font size
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container profilePhotos(double fontScaleFactor) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * 0.3, // Dynamically adjusting image size
      height: MediaQuery.of(context).size.width * 0.3, // Dynamically adjusting image size
      alignment: Alignment.center,
      child: const CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(
          "resimler/doktor.png",
        ),
      ),
    );
  }

  Widget contactDetail(double screenWidth, double fontScaleFactor) {
    return Card(
      margin: EdgeInsets.all(screenWidth * 0.05), // Adjust margin based on screen width
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildEditableTile("Şehir", city, Icons.location_city, (newValue) {
              setState(() {
                city = newValue;
              });
            }, fontScaleFactor),
            buildEditableTile("İlçe", district, Icons.my_location, (newValue) {
              setState(() {
                district = newValue;
              });
            }, fontScaleFactor),
            buildEditableTile("Adres", address, Icons.location_pin, (newValue) {
              setState(() {
                address = newValue;
              });
            }, fontScaleFactor),
            buildEditableTile("Telefon No", phone, Icons.phone_android,
                    (newValue) {
                  setState(() {
                    phone = newValue;
                  });
                }, fontScaleFactor),
            buildEditableTile("Email", email, Icons.mail, (newValue) {
              setState(() {
                email = newValue;
              });
            }, fontScaleFactor),
            buildEditableTile("Şifre", sifre, Icons.security, (newValue) {
              setState(() {
                sifre = newValue;
              });
            }, fontScaleFactor),
          ],
        ),
      ),
    );
  }

  Widget buildEditableTile(
      String title, String value, IconData icon, ValueChanged<String> onEdit, double fontScaleFactor) {
    return ListTile(
      iconColor: Colors.black,
      textColor: Colors.black,
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "ABeeZee",
            fontSize: MediaQuery.of(context).size.width * 0.04 * fontScaleFactor), // Dynamic font size
      ),
      subtitle: Text(
        value,
        style: TextStyle(
            color: Colors.black, fontFamily: "ABeeZee", fontSize: MediaQuery.of(context).size.width * 0.035 * fontScaleFactor), // Dynamic font size
      ),
      dense: true,
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => showEditDialog(context, title, value, onEdit),
      ),
    );
  }

  Card contactStatus(double screenWidth, double fontScaleFactor) {
    return Card(
      margin: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, screenWidth * 0.05, screenWidth * 0.05), // Dynamic margin
      color: Colors.white,
      child: ListTile(
        iconColor: Colors.black,
        textColor: Colors.black,
        title: Text(
          "Abonelik Durumu",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "ABeeZee",
              fontSize: MediaQuery.of(context).size.width * 0.04 * fontScaleFactor), // Dynamic font size
        ),
        subtitle: Text(
          "Aktif",
          style: TextStyle(
              color: Colors.black, fontFamily: "ABeeZee", fontSize: MediaQuery.of(context).size.width * 0.035 * fontScaleFactor), // Dynamic font size
        ),
        trailing: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AbonelikBilgiSayfasi()));
          },
          child: Text(
            "Görüntüle",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontFamily: "ABeeZee",
              fontSize: MediaQuery.of(context).size.width * 0.035 * fontScaleFactor, // Dynamic font size
            ),
          ),
        ),
        dense: true,
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final String aboutText;
  final ValueChanged<String> onEdit;
  final double fontScaleFactor;

  const AboutSection(
      {super.key, required this.aboutText, required this.onEdit, required this.fontScaleFactor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Card(
            margin: const EdgeInsets.all(20),
            color: beyaz,
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Text(
                aboutText,
                style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.04 * fontScaleFactor), // Dynamic font size
              ),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Düzenle",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.035 * fontScaleFactor, // Dynamic font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.red),
                  onPressed: () {
                    showEditDialog(context, "Hakkında", aboutText, onEdit);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
