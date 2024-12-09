import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({super.key});

  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  final _formKey = GlobalKey<FormState>();

  // Kontrol edilecek alanlar için TextEditingController'lar
  final TextEditingController tcController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController isimController = TextEditingController();
  final TextEditingController soyisimController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dogumTarihiController = TextEditingController();

  String? _selectedCinsiyet;

  // Telefon numarası için TextEditingController'ı dinlemek amacıyla sayfa yüklendiğinde listener ekleyelim
  @override
  void initState() {
    super.initState();
    telefonController.addListener(() {
      setState(() {}); // Telefon numarasındaki değişikliği güncellemek için
    });
  }

  void kayitOl() {
    if (_formKey.currentState!.validate()) {
      // Form valid ise bu işlemler yapılır
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kayıt Başarılı!")),
      );
    }
  }

  void iptal() {
    // Tüm alanları sıfırlama
    tcController.clear();
    telefonController.clear();
    isimController.clear();
    soyisimController.clear();
    sifreController.clear();
    emailController.clear();
    dogumTarihiController.clear();
    _selectedCinsiyet = null; // Cinsiyet de sıfırlanacak

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("İşlem iptal edildi.")),
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
              // Doğum Tarihi
              TextFormField(
                controller: dogumTarihiController,
                decoration: InputDecoration(
                  labelText: "Doğum Tarihiniz",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
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
              // Cinsiyet
              DropdownButtonFormField<String>(
                value: _selectedCinsiyet,
                decoration: const InputDecoration(
                  labelText: "Cinsiyet",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(child: Text("Erkek"), value: "Erkek"),
                  DropdownMenuItem(child: Text("Kadın"), value: "Kadın"),
                  DropdownMenuItem(child: Text("Diğer"), value: "Diğer"),
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
                    child: Text("Kayıt Ol"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green,foregroundColor: beyaz),
                  ),
                  ElevatedButton(
                    onPressed: iptal,
                    child: Text("İptal"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: beyaz),
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
