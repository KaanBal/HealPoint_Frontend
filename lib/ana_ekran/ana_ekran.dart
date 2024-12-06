import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';
import 'anaekranfonk.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

Future<void> ara(String aramaKelimesi) async {
  print("Aramaya Basıldı ");
}

class _AnaEkranState extends State<AnaEkran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beyaz,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 16.0, left: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Selam Kaan ',
                  style: TextStyle(fontSize: 22, fontFamily: "ABeeZee", fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    print("Image pressed!");
                  },
                  child: Image.asset(
                    'resimler/menu.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            Text(
              "Sağlıklı Günler",
              style: TextStyle(fontSize: 17, fontFamily: "PtSans", color: gri),
            ),
            const SizedBox(height: 15),
            // Arama Çubuğu
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  hintText: "Ara",
                  controller: controller,
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: Image.asset(
                    "resimler/search.png",
                    width: 30,
                    height: 30,
                  ),
                );
              },
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Yaklaşan Randevular ',
              style: TextStyle(fontSize: 22, fontFamily: "ABeeZee", fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                print('Schedule tıklandı');
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: beyaz,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: acikGri.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage('https://media.istockphoto.com/id/1190555653/tr/vekt%C3%B6r/t%C4%B1p-doktoru-profil-simgesi-erkek-doktor-avatar-vekt%C3%B6r-ill%C3%BCstrasyon.jpg?s=170667a&w=0&k=20&c=Jq7BljB3HJND48e8t_JHgRilKtZBr39UZqXeh_SeCYg='),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Prof. Dr. Mehmet Eriş',
                          style: TextStyle(fontSize: 17, fontFamily: "PtSans", fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Üroloji',
                          style: TextStyle(fontSize: 15, fontFamily: "PtSans", color: gri),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset(
                              'resimler/calendar.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'June 12, 9:30 AM',
                              style: TextStyle(fontSize: 18, fontFamily: "PtSans", color: gri),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Popüler Doktorlar',
              style: TextStyle(fontSize: 22, fontFamily: "ABeeZee", fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      print('Doctor 1 tıklandı');
                    },
                    child: DoctorCard(
                      name: 'Dr. Ahmet Eriş',
                      specialization: 'Estetisyen',
                      rating: '4.9',
                      reviews: '2435',
                      price: '\$25/hr',
                      favourite: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      print('Doctor 2 tıklandı');
                    },
                    child: DoctorCard(
                      name: 'Dr. Ahmet Eriş',
                      specialization: 'Estetisyen',
                      rating: '4.8',
                      reviews: '1930',
                      price: '\$30/hr',
                      favourite: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      print('Doctor 3 tıklandı');
                    },
                    child: DoctorCard(
                      name: 'Dr. Ahmet Eriş',
                      specialization: 'Estetisyen',
                      rating: '4.9',
                      reviews: '2435',
                      price: '\$25/hr',
                      favourite: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      print('Doctor 4 tıklandı');
                    },
                    child: DoctorCard(
                      name: 'Dr. Ahmet Eriş',
                      specialization: 'Estetisyen',
                      rating: '4.9',
                      reviews: '2435',
                      price: '\$25/hr',
                      favourite: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      print('Doctor 5 tıklandı');
                    },
                    child: DoctorCard(
                      name: 'Dr. Ahmet Eriş',
                      specialization: 'Estetisyen',
                      rating: '4.9',
                      reviews: '2435',
                      price: '\$25/hr',
                      favourite: true,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}