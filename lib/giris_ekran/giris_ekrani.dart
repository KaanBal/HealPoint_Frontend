import 'package:flutter/material.dart';
import 'package:yazilim_projesi/kay%C4%B1t/kay%C4%B1t_ol.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';
import 'girisekranfonks.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani>
    with SingleTickerProviderStateMixin {
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  final GirisEkranFonks fonksiyonlar = GirisEkranFonks();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // TabController oluşturuluyor.
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TabController ve diğer kontrolcüler bellekten temizleniyor.
    _tabController.dispose();
    telefonController.dispose();
    sifreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: beyaz,
      appBar: AppBar(
        backgroundColor: beyaz,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: koyuKirmizi,
          unselectedLabelColor: Colors.black,
          indicatorColor: koyuKirmizi,
          tabs: const [
            Tab(text: "Hasta Girişi"),
            Tab(text: "Doktor Girişi"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGirisForm(
            ekranGenisligi,
            ekranYuksekligi,
            "Hasta Girişi",
                () {
              fonksiyonlar.girisYap(
                context,
                telefonController.text,
                sifreController.text,
                telefonController,
                sifreController,
              );
            },
          ),
          _buildGirisForm(
            ekranGenisligi,
            ekranYuksekligi,
            "Doktor Girişi",
                () {
              fonksiyonlar.girisYap(
                context,
                telefonController.text,
                sifreController.text,
                telefonController,
                sifreController,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGirisForm(
      double ekranGenisligi,
      double ekranYuksekligi,
      String baslik,
      VoidCallback onPressed,
      ) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ekranGenisligi * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: koyuKirmizi,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                minimumSize:
                Size(ekranGenisligi * 0.8, ekranYuksekligi * 0.06),
              ),
              child: const Text(
                "Giriş Yap",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: ekranYuksekligi * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.person_add, color: koyuKirmizi),
                TextButton(
                  onPressed: () {
                    fonksiyonlar.kaydol(
                      context,
                      telefonController.text,
                      sifreController.text,
                      telefonController,
                      sifreController,
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KayitEkrani()));
                  },
                  child: Text("Kaydol", style: TextStyle(color: koyuKirmizi)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
