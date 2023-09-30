import 'package:mon_doctor/main.dart';
import 'package:onboarding/onboarding.dart';

import 'onboarding.dart';
import 'pages/home_page.dart';

import 'pages/login_regester_page.dart';

import 'package:flutter/material.dart';
import 'auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  HomeScreen();
          } else {
            return  Onbording();
          }
        });
  }
}
