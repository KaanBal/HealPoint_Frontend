import 'package:flutter/material.dart';
import 'package:yazilim_projesi/models/Appointments.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreen();
}

class _DoctorHomeScreen extends State<DoctorHomeScreen> {
  final List<Appointments> appointments = [];

  void _loadData() async {
    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Appoinments List"),
        ),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return const Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  "Text",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hasta ismi"),
                    Text("Time: "),
                    Text("Appoinment statu"),
                    Text("appoinment text")
                  ],
                ),
                leading: Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            );
          },
        )
        );
  }
}
