import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:yazilim_projesi/Hasta/yorum/doktorYorum_fonks.dart';
import 'package:yazilim_projesi/models/Doctors.dart';
import 'package:yazilim_projesi/models/Reviews.dart';

class DoctorCommentsScreen extends StatefulWidget {
  final String doctorId;
  Doctors doctor;

  DoctorCommentsScreen(
      {super.key, required this.doctorId, required this.doctor});

  @override
  State<DoctorCommentsScreen> createState() => _DoctorCommentsScreenState();
}

class _DoctorCommentsScreenState extends State<DoctorCommentsScreen> {
  final DoktorYorumFonks fonks = DoktorYorumFonks();

  List<Reviews>? comments;
  double averageRating = 0.0;
  bool isLoading = true;

  Future<void> _fetchComments() async {
    try {
      comments = await fonks.fetchComments(widget.doctorId);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error loading data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Yorumlar Görüntülenemedi")),
      );
    }
  }

  void _loadDataFromMockData() async {
    const String jsonfile = 'assets/MockData/review.json';

    try {
      final dataString = await rootBundle.loadString(jsonfile);
      final List<dynamic> reviewData = json.decode(dataString);
      comments = reviewData.map((data) => Reviews.fromJson(data)).toList();
      setState(() {
        isLoading = false;
        averageRating = widget.doctor.avgPoint ?? 0.0;
      });
    } catch (e) {
      print('Error loading mock data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchComments();
    //_loadDataFromMockData();
  }

  Widget _buildStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yorumlarım'),
        backgroundColor: Colors.red,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : comments == null || comments!.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 50, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        "Yorumlar Görüntülenemedi",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ortalama Puan
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildStars(
                              widget.doctor.avgPoint ?? 0.0), // Yıldızlar
                          const SizedBox(height: 8),
                          Text(
                            widget.doctor.avgPoint != null
                                ? widget.doctor.avgPoint!.toStringAsFixed(1)
                                : "0.0", // Ortalama puan yoksa "0.0" göster
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    // Yorumlar Listesi
                    Expanded(
                      child: ListView.builder(
                        itemCount: comments!.length,
                        itemBuilder: (context, index) {
                          final comment = comments![index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              title: Text(
                                '${comment.points} Yıldız',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                                  Text(comment.comments ?? "Yorum bulunamadı"),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
