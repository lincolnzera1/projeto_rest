import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_rest/pages/page1.dart';
import 'package:projeto_rest/pages/page2.dart';
import 'package:projeto_rest/pages/verifyEmailPage.dart';
import 'package:projeto_rest/widgets/buttonWidget.dart';
import 'package:projeto_rest/widgets/emailField.dart';
import 'package:projeto_rest/widgets/passwordWidget.dart';


class PageCadastro extends StatefulWidget {
  const PageCadastro({ Key? key }) : super(key: key);

  @override
  State<PageCadastro> createState() => PageCadastroState();
}

class PageCadastroState extends State<PageCadastro> {

  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro"),
      centerTitle: true,),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              EmailField(controller: nome, hint: "", label: "Nome Completo", icon: Icons.person,),
              const Divider(),
              EmailField(controller: email, hint: "", label: "Email", icon: Icons.email),
              const Divider(),
              PasswordWidget(senhaController: senha),
              const Divider(),
              ButtonWidget(onClick: () => cadastro(), label: "Cadastrar!", )
            ],
          ),
        ),
      ),
    );
  }

  cadastro()async{

    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text, 
      password: senha.text);
      userCredential.user!.updateDisplayName(nome.text);
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(
          builder:(context) => VerifyEmailPage()), 
        (route) => false); 
        
    } on FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Crie uma senha mais forte"),
          backgroundColor: Colors.redAccent,
          ),
        );
      }else if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email ja foi cadastrado"),
          backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

}