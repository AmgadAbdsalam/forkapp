import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseReadScreen extends StatefulWidget {
  const FirebaseReadScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirebaseReadScreenState createState() => _FirebaseReadScreenState();
}

class _FirebaseReadScreenState extends State<FirebaseReadScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child("robots");
  Map<String, dynamic> robotsData = {};

  @override
  void initState() {
    super.initState();
    // جلب البيانات عند التحديث
    _dbRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          robotsData = Map<String, dynamic>.from(event.snapshot.value as Map);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📡 بيانات الروبوتات")),
      body: robotsData.isEmpty
          ? Center(child: Text("لا توجد بيانات في قاعدة البيانات."))
          : ListView(
              children: robotsData.entries.map((entry) {
                String robotId = entry.key;
                Map data = entry.value;
                return ListTile(
                  title: Text("🤖 $robotId"),
                  subtitle: Text("بيانات: ${data.toString()}"),
                );
              }).toList(),
            ),
    );
  }
}
