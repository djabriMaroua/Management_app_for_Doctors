import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TeacherSearchPage(),
    );
  }
}

class TeacherSearchPage extends StatefulWidget {
  @override
  _TeacherSearchPageState createState() => _TeacherSearchPageState();
}

class _TeacherSearchPageState extends State<TeacherSearchPage> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  Map<String, dynamic>? teacherData;

  void searchTeacher() async {
    String nom = nomController.text;
    String prenom = prenomController.text;
    String teacherId = nom + prenom;

    DocumentSnapshot teacherSnapshot = await _firestore.collection('my_teachers').doc(teacherId).get();

    setState(() {
      teacherData = teacherSnapshot.data() as Map<String, dynamic>?; // Fetch teacher data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Teacher'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: prenomController,
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
            ElevatedButton(
              onPressed: () {
                searchTeacher(); // Search for the teacher when the button is pressed
              },
              child: Text('Rechercher Enseignant'),
            ),
            if (teacherData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text('Informations de l\'enseignant:'),
                  
                  Text('Nom: ${teacherData!['nom']}'),
                  Text('Prénom: ${teacherData!['prenom']}'),
                  Text('Etablissement: ${teacherData!['adj']}'),
                  //
                  // Add more fields here based on your data structure
                
                
                ],
              ),
          ],
        ),
      ),
    );
  }
}
