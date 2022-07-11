import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_rest/pages/page2.dart';
import 'package:projeto_rest/widgets/buttonWidget.dart';


class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({ Key? key }) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {

  bool emailIsVerified = false;
  Timer? timer;
  bool ativarBotao = true;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailIsVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!emailIsVerified){
      sendEmailVerification();
      timer = Timer.periodic(Duration(seconds: 2),
      (_) => checkEmailVerified(),
      );
    }
  }

  

  Future sendEmailVerification() async{
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        ativarBotao = false;
      });
      print("1");
      await Future.delayed(Duration(seconds: 5));
      print("2");
      setState(() {
        ativarBotao = true;
      });
    }catch(e){
      /* ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("aconteceu um erro na verificação de email"),
          backgroundColor: Colors.redAccent,
          ),
        ); */
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      emailIsVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(emailIsVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => emailIsVerified == true 
  ? Page2() 
  : Scaffold(
    appBar: AppBar(title: Text("Verifique seu email"),centerTitle: true,),
    body: Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          ButtonWidget(
            onClick: (){
              ativarBotao ? sendEmailVerification() : print("Não pode enviar de novo agora");
            }, 
            label: "Reenviar email"),
          ButtonWidget(
            onClick: (){
              FirebaseAuth.instance.signOut();
            },
            label: "Volte para a tela anterior")
        ],
      ),
    ),
  );
}