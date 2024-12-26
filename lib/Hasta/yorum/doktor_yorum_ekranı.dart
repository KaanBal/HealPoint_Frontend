import 'package:flutter/material.dart';
import 'package:yazilim_projesi/Hasta/yorum/doktorYorum_fonks.dart';
import 'package:yazilim_projesi/models/Reviews.dart';

class DoctorCommentsScreen extends StatefulWidget {
  final String doctorId;

  const DoctorCommentsScreen({super.key, required this.doctorId});

  @override
  State<DoctorCommentsScreen> createState() => _DoctorCommentsScreenState();
}

class _DoctorCommentsScreenState extends State<DoctorCommentsScreen> {
  final DoktorYorumFonks fonks = DoktorYorumFonks();

  List<Reviews> comments = [];
  double averageRating = 0.0;
  bool isLoading = true;

  Future<void> _fetchComments() async {
    try {
      comments = await fonks.fetchComments(widget.doctorId);
      setState(() {});
    } catch (e) {
      print("Error loading data: $e");
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
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: ListTile(
                                title: Text('${comment.points} Yıldız',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(comment.comments ?? "Yorum bulunamadı"),
                                trailing: Text(comment.createdAt.toString()),
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
