import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_rest/pages/page0.dart';
import 'package:projeto_rest/pages/page1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
    debugShowCheckedModeBanner: false, 
    home: MyApp(),
    theme: ThemeData(
      primarySwatch: Colors.lightGreen
    ),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page0();
  }
}
