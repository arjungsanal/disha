import 'package:disha/constant/typography.dart';
import 'package:disha/screens/landing_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    gotoLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(59, 7, 142, 0.8), // Lighter purple
              Color.fromRGBO(103, 13, 247, 0.898),  // Darker purple
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Disha',
                style: CustomStyle.TitleText.copyWith(
                  color: Colors.white,
                  fontSize: 75,
                  height: 0,
                ),
              ),
              Text("A new way of life",
              style: CustomStyle.Bold.copyWith(
                color: Colors.white,
                fontSize: 22
              ),
              
              )
            ],
          ),
          
        ),
      ),
    );
  }

   Future<void> gotoLogin() async{
   await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>LandingScreen()));
  }
}