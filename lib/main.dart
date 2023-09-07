import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mon_doctor/searchPatient.dart';

import 'PatientInformationPage.dart';
import 'TABLE.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: SearchPatientPage()
      
    );
  }
}
