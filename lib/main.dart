import 'package:flutter/material.dart';
import 'package:todo_application/model/model.dart';
import 'homePage.dart';
import 'homePage.dart';

void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      
    );
  }
}