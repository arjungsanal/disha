import 'package:disha/screens/landing_screen.dart';
import 'package:disha/screens/login_screen.dart';
import 'package:disha/screens/org/orgsignup.dart';
import 'package:disha/screens/profile_screen.dart';
import 'package:disha/screens/report_screen.dart';
import 'package:disha/screens/splash_screen.dart';
import 'package:disha/screens/user/home.dart';
import 'package:disha/screens/usersignin_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// DB Pass : 1h1WFO5D3uzXxnbo


final acess_id = 'b46333cd49184514fe49f70ec30a679d';
final secret_acess ='4a602c1e20b60b8ad0311373f44541a8e26164c69dd1e29821b8bf16f5307aa2';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vjixhrpflhhqbyvszlfo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZqaXhocnBmbGhocWJ5dnN6bGZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzcxOTE2NzYsImV4cCI6MjA1Mjc2NzY3Nn0.MVQpucgqjwGiAjO-Ixvuk9PQDorKso-051Te7FOIO9k',
  );
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
        'usersignin_screen' :(context)=>UserSigninScreen(),
        'userHome_screen' : (context)=>UserHome(),
        'orgSignup_screen' : (context)=>OrgSignupScreen(),
        'login_screen' : (context)=>  UserLoginScreen(),
        'profile_screen': (content)=>ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
      ),
      home:SplashScreen(),
    );
  }

  
}