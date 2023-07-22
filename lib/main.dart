import 'package:chapter_10/example_five.dart';
import 'package:chapter_10/example_four.dart';
import 'package:chapter_10/home_screen.dart';
import 'package:chapter_10/signup.dart';
import 'package:chapter_10/uploadimage.dart';
import 'package:chapter_10/userdata.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignupScreen(),
    );
  }
}


