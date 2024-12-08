import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

// Global showEditDialog function
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

class DoktorProfil extends StatefulWidget {
  const DoktorProfil({super.key});

  @override
  State<DoktorProfil> createState() => _DoktorProfilState();
}

class _DoktorProfilState extends State<DoktorProfil> {
  // Initial values for editable fields
  String city = "Adana";
  String district = "Sarıçam";
  String address = "156.sokak ahmetağa mah.";
  String phone = "+62 812345678";
  String email = "aseps.career@gmail.com";
  String sifre = "1234";
  String about =
      "Dr. Anderson is a highly respected and experienced psychiatrist known for his compassionate care and comprehensive approach to mental health. With over 15 years of experience in the field, Dr. Anderson..."
      "Dr. Anderson is a highly respected and experienced psychiatrist known for his compassionate care and comprehensive approach to mental health. With over 15 years of experience in the field, Dr. Anderson..."
      "Dr. Anderson is a highly respected and experienced psychiatrist known for his compassionate care and comprehensive approach to mental health. With over 15 years of experience in the field, Dr. Anderson...";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: beyaz,
        appBar: AppBar(
          backgroundColor: acikKirmizi,
          titleTextStyle: const TextStyle(
            color: Colors.white,
          ),
          toolbarHeight: 275,
          title: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Column(
              children: [
                profilePhotos(),
                profileName(),
                hobbies(),
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
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  contactDetail(),
                  contactStatus(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding hobbies() {
    return const Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Text(
        "Ürolog",
        style: TextStyle(
          fontFamily: "ABeeZee",
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      ),
    );
  }

  Padding profileName() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          "Dr. William Anderson",
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container profilePhotos() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      width: 105,
      height: 105,
      alignment: Alignment.center,
      child: const CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          "https://media.istockphoto.com/id/1190555653/tr/vekt%C3%B6r/t%C4%B1p-doktoru-profil-simgesi-erkek-doktor-avatar-vekt%C3%B6r-ill%C3%BCstrasyon.jpg?s=170667a&w=0&k=20&c=Jq7BljB3HJND48e8t_JHgRilKtZBr39UZqXeh_SeCYg=",
        ),
      ),
    );
  }

  Widget contactDetail() {
    return Card(
      margin: const EdgeInsets.all(20),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildEditableTile("Şehir", city, Icons.location_city, (newValue) {
              setState(() {
                city = newValue;
              });
            }),
            buildEditableTile("İlçe", district, Icons.my_location, (newValue) {
              setState(() {
                district = newValue;
              });
            }),
            buildEditableTile("Adres", address, Icons.location_pin, (newValue) {
              setState(() {
                address = newValue;
              });
            }),
            buildEditableTile("Telefon No", phone, Icons.phone_android, (newValue) {
              setState(() {
                phone = newValue;
              });
            }),
            buildEditableTile("Email", email, Icons.mail, (newValue) {
              setState(() {
                email = newValue;
              });
            }),
            buildEditableTile("Şifre", sifre, Icons.security, (newValue) {
              setState(() {
                sifre = newValue;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget buildEditableTile(String title, String value, IconData icon, ValueChanged<String> onEdit) {
    return ListTile(
      iconColor: Colors.black,
      textColor: Colors.black,
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: "ABeeZee", fontSize: 15),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(color: Colors.black, fontFamily: "ABeeZee", fontSize: 13),
      ),
      dense: true,
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => showEditDialog(context, title, value, onEdit),
      ),
    );
  }

  Card contactStatus() {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      color: Colors.white,
      child: ListTile(
        iconColor: Colors.black,
        textColor: Colors.black,
        title: const Text(
          "Abonelik Durumu",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "ABeeZee", fontSize: 15),
        ),
        subtitle: const Text(
          "Aktif",
          style: TextStyle(color: Colors.black, fontFamily: "ABeeZee", fontSize: 13),
        ),
        trailing: TextButton(
          onPressed: () {
            print("Abonelik durumu görüntülendi.");
          },
          child: const Text(
            "Görüntüle",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontFamily: "ABeeZee",
              fontSize: 14,
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

  const AboutSection({super.key, required this.aboutText, required this.onEdit});

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
                style: const TextStyle(color: Colors.black),
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
                const Text(
                  "Düzenle",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
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
