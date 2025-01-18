import 'package:disha/screens/landing_screen.dart';
import 'package:disha/screens/report_screen.dart';
import 'package:disha/screens/splash_screen.dart';
import 'package:flutter/material.dart';

// DB Pass : 1h1WFO5D3uzXxnbo

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'landing_screen' : (context)=> LandingScreen(),
        'report_screen' : (context)=>ReportScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
      ),
      home:SplashScreen(),
    );
  }

  
}