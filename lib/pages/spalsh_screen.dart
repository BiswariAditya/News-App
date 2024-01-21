import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/pages/homeScreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}



class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.sizeOf(context).height*1;
    final width= MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/istockphoto-1362788582-1024x1024.jpg',
            // fit: BoxFit.cover,
            width: width*1,
            height: height*0.5,),
            SizedBox(height: height*0.04,),
            Text('TOP HEADLINES', style: GoogleFonts.anton(letterSpacing: .6,color: Colors.grey.shade700,),),
            SizedBox(height: height*0.04,),
            SpinKitFadingCube(color: Colors.blueAccent,)

          ],
        )
      ),
    );
  }
}
