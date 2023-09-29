import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mon_doctor/pages/login_regester_page.dart';
import 'package:mon_doctor/searchPatient.dart';

import 'Examengynecologique.dart';
import 'PatientInformationPage.dart';

import 'TABLE.dart';
import 'onboarding.dart';

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
      theme: ThemeData(
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontSize: 18, // Adjust to your desired font size
            fontWeight: FontWeight.bold, // Adjust to your desired font weight
          ),
        ),
        primarySwatch: Colors.purple,
      ),
      home: Onbording(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void navigateToPage(BuildContext context, String pageName) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      // Return the widget for the desired page based on pageName
      if (pageName == 'exam') {
        return PatientInformationPage();
      } else if (pageName == 'exam2') {
        return SearchPatientPage();
      } else if (pageName == 'table') {
        return gynecologique();
      }
      // Return a default page or handle unknown page names as needed
      return Container();
    }));
  }

  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50))),
            child: Column(children: [
              const SizedBox(height: 80),
              ListTile(
                title: Text(
                  'Bonjour docteur  ',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
              )
            ]),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(100))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 40,
                  crossAxisSpacing: 30,
                  children: [
                    itemDashboard('Examen obstétricale n',
                        'images/enceinte.svg', Colors.deepPurple, 'exam'),
                    itemDashboard('Examen obstétricale a', 'images/mere.svg',
                        Colors.deepPurple, 'exam2'),
                    itemDashboard('Examen gyneco a', 'images/gyneco.svg',
                        Colors.deepPurple, 'table'),
                    itemDashboard('Examen gyneco n ', 'images/visite.svg',
                        Colors.deepPurple, 'table'),

                    // Add more items here with different SVG asset paths
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget itemDashboard(
      String title, String svgAssetPath, Color background, String pageName) {
    return GestureDetector(
      onTap: () {
        navigateToPage(context, pageName); // Call the navigation function
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: background, shape: BoxShape.circle),
              child: SvgPicture.asset(
                svgAssetPath, // Pass the SVG asset path here
                width: 32, // Set the width and height as needed
                height: 32,
                color: Colors.white, // Optional: Apply color to the icon
              ),
            ),
            SizedBox(height: 8), // Add spacing between icon and text
            Text(
              title, // Display the title as text
              style: TextStyle(
                color: Colors.black, // Customize text color as needed
                fontWeight: FontWeight.bold, // Customize font weight as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
