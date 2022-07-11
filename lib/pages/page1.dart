import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_rest/pages/page2.dart';
import 'package:projeto_rest/pages/pageCadastro.dart';
import 'package:projeto_rest/pages/verifyEmailPage.dart';
import 'package:projeto_rest/widgets/buttonWidget.dart';
import 'package:projeto_rest/widgets/emailField.dart';
import 'package:projeto_rest/widgets/passwordWidget.dart';
import 'package:projeto_rest/widgets/textfields.dart';

class Page1 extends StatefulWidget {
  const Page1({ Key? key }) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {

final formKey = GlobalKey<FormState>();
TextEditingController email = TextEditingController();
TextEditingController senha = TextEditingController();
final _firebaseAuth = FirebaseAuth.instance;

@override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    

    return Scaffold(
      //appBar: AppBar(),

      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child:  Container(
            alignment: Alignment.bottomCenter,
            color: Color.fromARGB(255, 162, 221, 35),
            height: MediaQuery.of(context).size.height,
            child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/lit.png", height: 110,),
                    SizedBox(height: 50,),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.61,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70.0),
                        topLeft: Radius.circular(70.0)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.11,),
                          EmailField(controller: email, hint: "teste@gmail.com", label: "Email", icon: Icons.email,),
                          const Divider(),
                          PasswordWidget(senhaController: senha,),
                          const Divider(),
                          button(),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Não possui cadastro?"), 
                              Listener(
                                onPointerDown:(_){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PageCadastro()));
                                },
                                child: Text("Cadastre-se", style: TextStyle(color: Colors.blue),),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
          ),
        ),
      ),
    );
  }
  Widget button() => ButtonWidget(
    onClick: (){
      final form = formKey.currentState!;
      if (form.validate()) {
        
      }
      login();
    },
    label: "Login!",
  );

  login() async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.text, 
        password: senha.text
      );
      if(userCredential != null){
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => VerifyEmailPage())
        );
      }
    }on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        print("Erro foi: ${e.code}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuario nao achado"),
          backgroundColor: Colors.redAccent,
          ),
        );
      }else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Senha errada"),
          backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

}


