import 'package:flutter/material.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';

class DoctorCard extends StatefulWidget {
  final String name;
  final String specialization;
  final String rating;
  final VoidCallback onFavoriteTap;
  bool favourite;

  DoctorCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.favourite,
    required this.onFavoriteTap,
  });

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth * 0.1;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
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
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage: AssetImage('resimler/doktor.png'),
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.asset(
                  'resimler/doktor.png',
                  fit: BoxFit.cover, // Resmin sığması için
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontFamily: "PtSans",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.favourite = !widget.favourite;
                          });
                          widget.onFavoriteTap();
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
                  const SizedBox(height: 8), // Boşluk ekleyerek düzenli görünüm
                  Text(
                    "Rating: ${widget.rating}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "PtSans",
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
