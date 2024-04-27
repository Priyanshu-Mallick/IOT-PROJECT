import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showContainer = false;
  bool showScreen = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      setState(() {
        showContainer = true;
      });
    });
    Timer(Duration(seconds: 1), () {
      setState(() {
        showScreen = true;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          AnimatedPositioned(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            bottom: showScreen ? MediaQuery.of(context).size.height * 0.2 : -700,
            left: MediaQuery.of(context).size.width * 0.15,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/logo.avif',
                fit: BoxFit.contain,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            bottom: showContainer ? 60 : -200,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 65),
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: (){
                  //priyanshu maghia to kama eita
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Card(
                  color: Color(0xFF002366),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/google.png",
                          height: 30,
                            width: 30,
                        ),
                        SizedBox(width: 10,),
                        Text("Signup with Google", style: TextStyle(fontSize: 22, color: Colors.white),),
                      ]
                    ),
                  ),
                ),
              )
            )
          ),

        ],
      ),
    );
  }
}
