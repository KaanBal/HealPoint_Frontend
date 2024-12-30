import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/models/Patients.dart';
import 'package:yazilim_projesi/renkler/renkler.dart';
import 'package:yazilim_projesi/Hasta/yorum/hastaYorum_fonks.dart';
import 'package:yazilim_projesi/models/Appointments.dart';
import 'package:yazilim_projesi/models/Reviews.dart';

class DoctorRatingScreen extends StatefulWidget {
  final Appointments appointment;

  const DoctorRatingScreen({super.key, required this.appointment});

  @override
  State<DoctorRatingScreen> createState() => _DoctorRatingScreenState();
}

class _DoctorRatingScreenState extends State<DoctorRatingScreen> {
  final HastaYorumFonks hastaYorumFonks = HastaYorumFonks();
  double _rating = 0.0;
  String _comment = '';
  String doctorName = 'Yükleniyor...';
  String branch = 'Yükleniyor...';
  String appointmentDate = 'Yükleniyor...';
  Appointments? appointment;
  Patients? patient;

  @override
  void initState() {
    super.initState();
    _loadData();
    _initializeAppointmentData();
  }

  void _loadData() async {
    try {
      patient = await hastaYorumFonks.loadData();
      setState(() {});
    } catch (e) {
      print("Error loading data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Yorumlar Görüntülenemedi")),
      );
    }
  }

  void _initializeAppointmentData() {
    appointment = widget.appointment;
    setState(() {
      doctorName = appointment?.doctor?.name ?? "Doktor adı mevcut değil";
      branch = appointment?.doctor?.branch ?? "Bölüm mevcut değil";
      appointmentDate = appointment?.appointmentDate != null
          ? DateFormat('yyyy-MM-dd').format(appointment!.appointmentDate!)
          : "Tarih mevcut değil";
    });
  }

  void _submitRating() async {
    if (_rating == 0 || _comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir puan ve yorum girin.')),
      );
      return;
    }

    try {
      if (appointment != null) {
        final review = Reviews(
            comments: _comment,
            points: _rating.toInt(),
            patient: patient,
            appointment: appointment);
        await hastaYorumFonks.createReview(review);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Değerlendirmeniz alındı!')),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      print("Error submitting review: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Değerlendirme gönderilemedi.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        backgroundColor: acikKirmizi,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Doktor Değerlendirme',
            style: TextStyle(
              fontFamily: "ABeeZee",
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Text(
                  doctorName,
                  style: const TextStyle(
                    fontFamily: "ABeeZee",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Branş: $branch',
                style: const TextStyle(
                  fontFamily: "ABeeZee",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Randevu Tarihi: $appointmentDate',
                style: const TextStyle(
                  fontFamily: "ABeeZee",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Puanlama',
                style: TextStyle(
                  fontFamily: "ABeeZee",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              RatingBar(
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Yorum Girişi
              const Text(
                'Yorum',
                style: TextStyle(
                  fontFamily: "ABeeZee",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Yorumunuzu yazınız...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontFamily: "ABeeZee",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                ),
                onChanged: (value) {
                  _comment = value;
                },
              ),
              const SizedBox(height: 24),

              // Gönder Butonu
              ElevatedButton(
                onPressed: _submitRating,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, foregroundColor: beyaz),
                child: const Text("Gönder"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingBar extends StatefulWidget {
  final Function(double) onRatingUpdate;

  const RatingBar({super.key, required this.onRatingUpdate});

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double _currentRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            _currentRating >= index + 1 ? Icons.star : Icons.star_border,
            color: koyuKirmizi,
          ),
          onPressed: () {
            setState(() {
              _currentRating = index + 1.0;
            });
            widget.onRatingUpdate(_currentRating);
          },
        );
      }),
    );
  }
}
