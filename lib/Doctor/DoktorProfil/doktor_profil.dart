import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/doktorProfil_fonks.dart';
import 'package:yazilim_projesi/Doctor/DoktorProfil/doktor_abonelik.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

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
  final DoktorProfilFonks fonks = DoktorProfilFonks();

  String? _selectedCity;
  String? _selectedDistrict;
  Map<String, List<String>> cityDistrictMap = {};
  List<String> _districts = [];
  Doctors? doctor;
  String? aboutText;

  @override
  void initState() {
    super.initState();
    _loadCityDistrictData();
    _fetchDoctorInfo();
    //_loadDataFromMockData();
  }

  Future<void> _loadCityDistrictData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/MockData/sehir_ilce.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        cityDistrictMap = jsonData.map(
            (key, value) => MapEntry(key, List<String>.from(value as List)));
      });
    } catch (e) {
      debugPrint("Error loading JSON data: $e");
    }
  }

  void _fetchDoctorInfo() async {
    try {
      final doctorInfo = await fonks.loadData();
      setState(() {
        doctor = doctorInfo;
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Doktor Bilgileri Görüntülünemedi")),
      );
    }
  }

  Future<void> _updateDoctorData() async {
    doctor?.about = aboutText;
    if (doctor != null) {
      try {
        await fonks.updateDoctor(doctor!);
        debugPrint("Doctor data updated successfully.");
      } catch (e) {
        debugPrint("Error updating doctor data: $e");
      }
    }
  }

  void _loadDataFromMockData() async {
    const String jsonFile = 'assets/MockData/doctorInfo.json';
    final dataString = await rootBundle.loadString(jsonFile);
    final Map<String, dynamic> dataJson = jsonDecode(dataString);
    setState(() {
      doctor = Doctors.fromJson(dataJson);
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _updateDoctorData();
    }
    super.dispose();
  }

  // Şehir düzenleme dialogu
  void showCityEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Şehir Seçin"),
        content: StatefulBuilder(
          builder: (context, setStateDialog) {
            return DropdownButtonFormField<String>(
              key: UniqueKey(),
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
                setStateDialog(() {
                  _selectedCity = value;
                  _districts = cityDistrictMap[value] ?? [];
                  _selectedDistrict = null;
                  doctor?.district = null;
                });
                setState(() {});
              },
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("İptal", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              if (_selectedCity != null) {
                setState(() {
                  doctor?.city = _selectedCity!;
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text("Kaydet", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  // İlçe düzenleme dialogu
  void showDistrictEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("İlçe Seçin"),
        content: DropdownButtonFormField<String>(
          value: _selectedDistrict,
          decoration: const InputDecoration(
            labelText: "İlçe",
            border: OutlineInputBorder(),
          ),
          items: _districts.map((district) {
            return DropdownMenuItem(
              value: district,
              child: Text(district),
            );
          }).toList(),
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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("İptal", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              if (_selectedDistrict != null) {
                setState(() {
                  doctor?.district = _selectedDistrict!;
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text("Kaydet", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontScaleFactor = 0.8;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: beyaz,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.42),
          child: AppBar(
            backgroundColor: acikKirmizi,
            automaticallyImplyLeading: false,
            flexibleSpace: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  child: Navigator.canPop(context)
                      ? IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        )
                      : const SizedBox(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.05 +
                        MediaQuery.of(context).padding.top,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      profilePhotos(fontScaleFactor),
                      profileName(fontScaleFactor),
                      hobbies(fontScaleFactor),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
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
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: AboutSection(
                aboutText: doctor?.about ?? "",
                onEdit: (newValue) {
                  setState(() {
                    doctor?.about = newValue;
                    aboutText = newValue;
                  });
                  _updateDoctorData();
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
        doctor?.branch ?? "Branş Bulunamadı",
        style: TextStyle(
          fontFamily: "ABeeZee",
          fontWeight: FontWeight.normal,
          fontSize: MediaQuery.of(context).size.width * 0.04 * fontScaleFactor,
        ),
      ),
    );
  }

  Padding profileName(double fontScaleFactor) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          "${doctor?.name ?? ""} ${doctor?.surname ?? ""}",
          style: TextStyle(
            fontFamily: "ABeeZee",
            fontSize:
                MediaQuery.of(context).size.width * 0.045 * fontScaleFactor,
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
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
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
      margin: EdgeInsets.all(screenWidth * 0.05),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildEditableTile("Şehir", doctor?.city ?? "", Icons.location_city,
                (newValue) {
              setState(() {
                doctor?.city = newValue;
              });
              showCityEditDialog(context);
            }, fontScaleFactor, isDropdown: true),
            buildEditableTile("İlçe", doctor?.district ?? "", Icons.my_location,
                (newValue) {
              setState(() {
                doctor?.district = newValue;
              });
              showDistrictEditDialog(context);
            }, fontScaleFactor, isDropdown: true),
            buildEditableTile(
                "Adres", doctor?.address ?? "", Icons.location_pin, (newValue) {
              setState(() {
                doctor?.address = newValue;
              });
            }, fontScaleFactor, isDropdown: false),
            buildEditableTile(
                "Telefon No", doctor?.phoneNumber ?? "", Icons.phone_android,
                (newValue) {
              setState(() {
                doctor?.phoneNumber = newValue;
              });
            }, fontScaleFactor, isDropdown: false),
            buildEditableTile("Email", doctor?.email ?? "", Icons.mail,
                (newValue) {
              setState(() {
                doctor?.email = newValue;
              });
            }, fontScaleFactor, isDropdown: false),
            buildEditableTile("Şifre", doctor?.password ?? "", Icons.security,
                (newValue) {
              setState(() {
                doctor?.password = newValue;
              });
            }, fontScaleFactor, isDropdown: false),
          ],
        ),
      ),
    );
  }

  Widget buildEditableTile(String title, String value, IconData icon,
      ValueChanged<String> onEdit, double fontScaleFactor,
      {required bool isDropdown}) {
    return ListTile(
      iconColor: Colors.black,
      textColor: Colors.black,
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "ABeeZee",
            fontSize:
                MediaQuery.of(context).size.width * 0.04 * fontScaleFactor),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
            color: Colors.black,
            fontFamily: "ABeeZee",
            fontSize:
                MediaQuery.of(context).size.width * 0.035 * fontScaleFactor),
      ),
      dense: true,
      trailing: isDropdown
          ? IconButton(
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
              onPressed: () => onEdit(value),
            )
          : IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showEditDialog(context, title, value, onEdit);
              },
            ),
    );
  }

  Card contactStatus(double screenWidth, double fontScaleFactor) {
    return Card(
      margin: EdgeInsets.fromLTRB(
          screenWidth * 0.05, 0, screenWidth * 0.05, screenWidth * 0.05),
      color: Colors.white,
      child: ListTile(
        iconColor: Colors.black,
        textColor: Colors.black,
        title: Text(
          "Abonelik Durumu",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "ABeeZee",
              fontSize:
                  MediaQuery.of(context).size.width * 0.04 * fontScaleFactor),
        ),
        subtitle: Text(
          doctor?.isAccountActive ?? false ? "AKTIF" : "Aktif Değil",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "ABeeZee",
              fontSize:
                  MediaQuery.of(context).size.width * 0.035 * fontScaleFactor),
        ),
        trailing: TextButton(
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AbonelikBilgiSayfasi()))
                .then((_) {
              _updateDoctorData();
              _fetchDoctorInfo();
            });
          },
          child: Text(
            "Görüntüle",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontFamily: "ABeeZee",
              fontSize:
                  MediaQuery.of(context).size.width * 0.035 * fontScaleFactor,
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

  const AboutSection({
    super.key,
    required this.aboutText,
    required this.onEdit,
    required this.fontScaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    final double sectionWidth = MediaQuery.of(context).size.width * 0.85;

    return Column(
      children: [
        SizedBox(
          width: sectionWidth,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: beyaz,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                aboutText.isEmpty
                    ? "Bu doktor hakkında hiçbir açıklama yok."
                    : aboutText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width *
                      0.04 *
                      fontScaleFactor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: sectionWidth,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
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
                      fontSize: MediaQuery.of(context).size.width *
                          0.035 *
                          fontScaleFactor,
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
        ),
      ],
    );
  }
}
