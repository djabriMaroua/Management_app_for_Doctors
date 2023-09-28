import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mon_doctor/main.dart';
import 'content_model.dart';
import 'home.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: contents.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (_, i) {
          return buildPage(contents[i]);
        },
      ),
      bottomSheet: Container(
        height: 60,
        margin: EdgeInsets.all(60),
        width: double.infinity,
        child: TextButton(
          child: Text(
              currentIndex == contents.length - 1 ? "Continue" : "Next"),
          onPressed: () {
            if (currentIndex == contents.length - 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ),
              );
            }
            _controller.nextPage(
              duration: Duration(milliseconds: 100),
              curve: Curves.bounceIn,
            );
          },
        ),
      ),
    );
  }

  Widget buildPage(UnbordingContent content) {
    
  return Column(

    children: [
      SizedBox(height: 50), 
      SizedBox(height: 40),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20), // Adjust padding as needed
        child: SvgPicture.asset(
          content.image,
          height: 200,
          width: 300.08,
        ),
      ),
       SizedBox(height: 70), 
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20), // Adjust padding as needed
        child: Text(
          content.title,
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 20),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20), // Adjust padding as needed
        child: Text(
          content.discription,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      )
    ],
  );
}

}
