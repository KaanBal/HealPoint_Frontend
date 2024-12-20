import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Hasta/Hasta_kayit/hastakayit_fonks.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class HastaKayitOl extends StatefulWidget {
  const HastaKayitOl({super.key});

  @override
  _HastaKayitOlState createState() => _HastaKayitOlState();
}

class _HastaKayitOlState extends State<HastaKayitOl> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tcController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController isimController = TextEditingController();
  final TextEditingController soyisimController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dogumTarihiController = TextEditingController();

  String? _selectedCinsiyet;
  final HastakayitFonks hastakayitFonks = HastakayitFonks();

  @override
  void initState() {
    super.initState();
    telefonController.addListener(() {
      setState(() {});
    });
  }

  void kayitOl() async {
    if (_formKey.currentState!.validate()) {
      await hastakayitFonks.kayitOl(
        tc: tcController.text,
        phoneNumber: telefonController.text,
        name: isimController.text,
        surname: soyisimController.text,
        password: sifreController.text,
        email: emailController.text,
        birthDate: dogumTarihiController.text,
        gender: _selectedCinsiyet!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kayıt Başarılı!")),
      );
    }
  }

  void iptal() {
    tcController.clear();
    telefonController.clear();
    isimController.clear();
    soyisimController.clear();
    sifreController.clear();
    emailController.clear();
    dogumTarihiController.clear();
    _selectedCinsiyet = null;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("İşlem iptal edildi.")),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        dogumTarihiController.text =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıt Ol"),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: beyaz,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: tcController,
                decoration: const InputDecoration(
                  labelText: "TC Kimlik Numarası",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 11,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen TC kimlik numaranızı girin.";
                  }
                  if (value.length != 11 || int.tryParse(value) == null) {
                    return "TC kimlik numarası 11 haneli olmalı.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: telefonController,
                decoration: const InputDecoration(
                  labelText: "Telefon Numarası",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen telefon numaranızı girin.";
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return "Telefon numarası 10 haneli olmalı.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Telefon numaranızın başında 0 olmadan yazınız.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: isimController,
                decoration: const InputDecoration(
                  labelText: "Adınız",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen adınızı girin.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: soyisimController,
                decoration: const InputDecoration(
                  labelText: "Soyadınız",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen soyadınızı girin.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "E-posta",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen e-posta adresinizi girin.";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Geçerli bir e-posta adresi girin.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: sifreController,
                decoration: const InputDecoration(
                  labelText: "Şifre",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen şifrenizi girin.";
                  }
                  if (value.length < 6) {
                    return "Şifre en az 6 karakter olmalı.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: dogumTarihiController,
                decoration: InputDecoration(
                  labelText: "Doğum Tarihiniz",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen doğum tarihinizi seçin.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCinsiyet,
                decoration: const InputDecoration(
                  labelText: "Cinsiyet",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "Erkek", child: Text("Erkek")),
                  DropdownMenuItem(value: "Kadın", child: Text("Kadın")),
                  DropdownMenuItem(value: "Diğer", child: Text("Diğer")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCinsiyet = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen cinsiyetinizi seçin.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: kayitOl,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, foregroundColor: beyaz),
                    child: const Text("Kayıt Ol"),
                  ),
                  ElevatedButton(
                    onPressed: iptal,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, foregroundColor: beyaz),
                    child: const Text("İptal"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
