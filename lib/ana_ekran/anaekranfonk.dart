import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class Anaekranfonk extends StatefulWidget {
  const Anaekranfonk({super.key});

  @override
  State<Anaekranfonk> createState() => _AnaekranfonkState();
}

class DoctorCard extends StatefulWidget {
  final String name;
  final String specialization;
  final String rating;
  final String reviews;
  final String price;
  bool favourite;

  DoctorCard({
    required this.name,
    required this.specialization,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.favourite,
  });

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 5.0,right: 5.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: beyaz,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gri.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://media.istockphoto.com/id/1190555653/tr/vekt%C3%B6r/t%C4%B1p-doktoru-profil-simgesi-erkek-doktor-avatar-vekt%C3%B6r-ill%C3%BCstrasyon.jpg?s=170667a&w=0&k=20&c=Jq7BljB3HJND48e8t_JHgRilKtZBr39UZqXeh_SeCYg='),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 180.0),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontFamily: "PtSans",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Favourite icon
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.favourite = !widget.favourite;
                        });
                      },
                      child: Icon(
                        Icons.favorite,
                        color: widget.favourite ? koyuKirmizi : acikGri,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.specialization,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "PtSans",
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      style: const TextStyle(
                        fontFamily: "PtSans",
                        fontSize: 15,
                      ),
                      '${widget.rating} (${widget.reviews} Değerlendirme)',
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.price,
                      style: const TextStyle(
                        fontFamily: "PtSans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AnaekranfonkState extends State<Anaekranfonk> {

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

}
