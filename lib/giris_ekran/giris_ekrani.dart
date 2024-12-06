import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';
import 'girisekranfonks.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  int selectedIndex = 0;
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();

  final GirisEkranFonks fonksiyonlar = GirisEkranFonks();

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: beyaz,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Hasta Girişi',
                            style: TextStyle(
                              fontSize: ekranGenisligi / 20,
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 0 ? koyuKirmizi : Colors.black,
                            ),
                          ),
                          if (selectedIndex == 0)
                            Container(
                              margin: const EdgeInsets.only(top: 4.0),
                              height: 2,
                              width: ekranGenisligi / 8,
                              color: koyuKirmizi,
                            ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Doktor Girişi',
                            style: TextStyle(
                              fontSize: ekranGenisligi / 20,
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 1 ? koyuKirmizi : Colors.black,
                            ),
                          ),
                          if (selectedIndex == 1)
                            Container(
                              margin: const EdgeInsets.only(top: 4.0),
                              height: 2,
                              width: ekranGenisligi / 8,
                              color: koyuKirmizi,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ekranYuksekligi * 0.05),
                CircleAvatar(
                  radius: ekranGenisligi / 10,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.people,
                    size: ekranGenisligi / 10,
                    color: koyuKirmizi,
                  ),
                ),
                SizedBox(height: ekranYuksekligi * 0.05),
                TextField(
                  controller: telefonController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Telefon Numarası",
                    labelStyle: TextStyle(color: koyuKirmizi),
                    prefixIcon: Icon(Icons.phone, color: koyuKirmizi),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: koyuKirmizi),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: koyuKirmizi),
                    ),
                  ),
                ),
                SizedBox(height: ekranYuksekligi * 0.03),
                TextField(
                  controller: sifreController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    labelStyle: TextStyle(color: koyuKirmizi),
                    prefixIcon: Icon(Icons.lock, color: koyuKirmizi),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: koyuKirmizi),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: koyuKirmizi),
                    ),
                  ),
                ),
                SizedBox(height: ekranYuksekligi * 0.05),
                ElevatedButton(
                  onPressed: () {
                    fonksiyonlar.girisYap(
                      context,
                      telefonController.text,
                      sifreController.text,
                      telefonController,
                      sifreController,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: koyuKirmizi,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(ekranGenisligi * 0.8, ekranYuksekligi * 0.06),
                  ),
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ekranGenisligi / 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 21.0, top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.person_add,
                        color: koyuKirmizi,
                      ),
                      TextButton(
                        onPressed: () {
                          fonksiyonlar.kaydol(
                            context,
                            telefonController.text,
                            sifreController.text,
                            telefonController,
                            sifreController,
                          );
                        },
                        child: Text(
                          "Kaydol",
                          style: TextStyle(
                            color: koyuKirmizi,
                            fontSize: ekranGenisligi / 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
