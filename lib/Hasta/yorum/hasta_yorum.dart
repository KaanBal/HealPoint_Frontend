import 'package:flutter/material.dart';

class DoctorRatingScreen extends StatefulWidget {
  const DoctorRatingScreen({super.key});

  @override
  State<DoctorRatingScreen> createState() => _DoctorRatingScreenState();
}

class _DoctorRatingScreenState extends State<DoctorRatingScreen> {
  double _rating = 0.0;
  String _comment = '';
  String doctorName = '';
  String branch = '';
  String appointmentDate = '';


  Future<void> _fetchDoctorData() async {
    
  }

  @override
  void initState() {
    super.initState();
    _fetchDoctorData();
  }

  void _submitRating() {
    print('Puan: $_rating, Yorum: $_comment');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Değerlendirmeniz alındı!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(77),
        child: AppBar(
          elevation: 6,
          backgroundColor: Colors.red,
          title: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.0),
            child: Text(
              'Doktor Değerlendirme',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold, // Kalın yazı tipi
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Branş: $branch',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Kalın yazı tipi
                  color: Colors.black, // Renk değiştirilebilir
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Randevu Tarihi: $appointmentDate',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              // Yıldız Puanlama
              const Text(
                'Puanlama',
                style: TextStyle(
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Yorumunuzu yazınız...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
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
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Gönder',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Yıldız Puanlama Widget'ı
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
            color: Colors.amber,
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
