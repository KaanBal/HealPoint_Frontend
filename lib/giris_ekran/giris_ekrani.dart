import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';
import 'package:yazilim_projesi/services/auth_service.dart';
import '../Doctor/Doktor_kayit/doktor_kayit_ol.dart';
import '../Hasta/Hasta_kayit/hasta_kayit_ol.dart';
import 'girisekranfonks.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani>
    with SingleTickerProviderStateMixin {
  final TextEditingController tcController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  final GirisEkranFonks fonksiyonlar = GirisEkranFonks();
  final AuthService authService = AuthService();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    tcController.dispose();
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
                tcController.text,
                sifreController.text,
                tcController,
                sifreController,
                true, 
                authService,
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
                tcController.text,
                sifreController.text,
                tcController,
                sifreController,
                false, 
                authService,
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
              controller: tcController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "TC Kimlik Numarası",
                labelStyle: TextStyle(color: koyuKirmizi),
                prefixIcon: Icon(Icons.credit_card, color: koyuKirmizi),
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
                minimumSize: Size(ekranGenisligi * 0.8, ekranYuksekligi * 0.06),
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
                    if (_tabController.index == 0) {
                      fonksiyonlar.kaydol(
                        context,
                        tcController.text,
                        sifreController.text,
                        tcController,
                        sifreController,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HastaKayitOl()),
                      );
                    } else if (_tabController.index == 1) {
                      fonksiyonlar.kaydol(
                        context,
                        tcController.text,
                        sifreController.text,
                        tcController,
                        sifreController,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoktorKayitOl()),
                      );
                    }
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
