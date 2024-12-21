import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../renkler/renkler.dart';

class DoktorKayitOl extends StatefulWidget {
  const DoktorKayitOl({super.key});

  @override
  State<DoktorKayitOl> createState() => _DoktorKayitOlState();
}

class _DoktorKayitOlState extends State<DoktorKayitOl> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tcController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController isimController = TextEditingController();
  final TextEditingController soyisimController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController dogumTarihiController = TextEditingController();

  String? _selectedCinsiyet;
  String? _selectedCity;
  String? _selectedDistrict;
  String? _selectedBranch;

  Map<String, List<String>> cityDistrictMap = {};
  List<String> _districts = [];

  final List<String> branches = [
    "Diş",
    "Kalp",
    "Ortopedi",
    "Göz",
    "Dahiliye",
  ];

  @override
  void initState() {
    super.initState();
    _loadCityDistrictData();
    telefonController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _loadCityDistrictData() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/sehir_ilce.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        cityDistrictMap = jsonData.map((key, value) =>
            MapEntry(key, List<String>.from(value as List)));
      });
    } catch (e) {
      debugPrint("Error loading JSON data: $e");
    }
  }

  void kayitOl() {
    if (_formKey.currentState!.validate()) {
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
    adresController.clear();
    dogumTarihiController.clear();
    _selectedCity = null;
    _districts = [];
    _selectedDistrict = null;
    _selectedBranch = null;
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
            DropdownButtonFormField<String>(
            value: _selectedCity,
            decoration: const InputDecoration(
              labelText: "Şehir",
              border: OutlineInputBorder(),
            ),
            items: cityDistrictMap.keys.map((city) {
              return DropdownMenuItem(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCity = value;
                _districts = cityDistrictMap[value] ?? [];
                _selectedDistrict = null;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Lütfen bir şehir seçin.";
              }
              return null;
            },
          ),

            const SizedBox(height: 10),

              // İlçe Dropdown
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                decoration: const InputDecoration(
                  labelText: "İlçe",
                  border: OutlineInputBorder(),
                ),
                items: _districts
                    .map((district) => DropdownMenuItem(
                  value: district,
                  child: Text(district),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDistrict = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen bir ilçe seçin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // TC Kimlik No
              TextFormField(
                controller: tcController,
                decoration: const InputDecoration(
                  labelText: "TC Kimlik No",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 11,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 11) {
                    return "Lütfen geçerli bir TC Kimlik No girin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Telefon
              TextFormField(
                controller: telefonController,
                decoration: const InputDecoration(
                  labelText: "Telefon",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen telefon numaranızı girin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // İsim
              TextFormField(
                controller: isimController,
                decoration: const InputDecoration(
                  labelText: "İsim",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen isminizi girin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Soyisim
              TextFormField(
                controller: soyisimController,
                decoration: const InputDecoration(
                  labelText: "Soyisim",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen soyisminizi girin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Şifre
              TextFormField(
                controller: sifreController,
                decoration: const InputDecoration(
                  labelText: "Şifre",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return "Lütfen en az 6 karakterli bir şifre girin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return "Lütfen geçerli bir email adresi girin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Adres
              TextFormField(
                controller: adresController,
                decoration: const InputDecoration(
                  labelText: "Adres",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen adresinizi girin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Doğum Tarihi
              TextFormField(
                controller: dogumTarihiController,
                decoration: const InputDecoration(
                  labelText: "Doğum Tarihi",
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen doğum tarihinizi seçin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Cinsiyet Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCinsiyet,
                decoration: const InputDecoration(
                  labelText: "Cinsiyet",
                  border: OutlineInputBorder(),
                ),
                items: ["Erkek", "Kadın"].map((cinsiyet) => DropdownMenuItem(
                  value: cinsiyet,
                  child: Text(cinsiyet),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCinsiyet = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen cinsiyet seçin.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Branş Dropdown
              DropdownButtonFormField<String>(
                value: _selectedBranch,
                decoration: const InputDecoration(
                  labelText: "Branş",
                  border: OutlineInputBorder(),
                ),
                items: branches.map((branch) => DropdownMenuItem(
                  value: branch,
                  child: Text(branch),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBranch = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen branş seçin.";
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
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      "Kayıt Ol",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: iptal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      "İptal",
                      style: TextStyle(color: Colors.white),
                    ),
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
