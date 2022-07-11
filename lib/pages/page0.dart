import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_rest/pages/page1.dart';
import 'package:projeto_rest/pages/page2.dart';

class Page0 extends StatefulWidget {
  const Page0({ Key? key }) : super(key: key);

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
      if(user == null){
        print("Usuario deslogado!");
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => Page1())
        );
      }else{
        print("Usuario logado");
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => Page2())
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}