import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorCommentsScreen extends StatefulWidget {
  final String doctorId; 

  const DoctorCommentsScreen({super.key, required this.doctorId});

  @override
  State<DoctorCommentsScreen> createState() => _DoctorCommentsScreenState();
}

class _DoctorCommentsScreenState extends State<DoctorCommentsScreen> {
  List<Map<String, dynamic>> comments = [];
  double averageRating = 0.0;
  bool isLoading = true;

  final String apiUrl = 'https://api.example.com/getDoctorComments'; 

  Future<void> _fetchComments() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?doctorId=${widget.doctorId}'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          comments = List<Map<String, dynamic>>.from(data['comments'] ?? []);
          averageRating = data['averageRating'] ?? 0.0; 
          isLoading = false;
        });
      } else {
        throw Exception('Yorumlar alınamadı');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchComments();
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
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ortalama Puan
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildStars(averageRating.roundToDouble()), // Yıldızlar
                const SizedBox(height: 8),
                Text(
                  averageRating.toStringAsFixed(2),
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
            child: comments.isEmpty
                ? const Center(child: Text('Henüz yorum yok.'))
                : ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('${comment['rating']} Yıldız',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(comment['comment']),
                    trailing: Text(comment['date']),
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
