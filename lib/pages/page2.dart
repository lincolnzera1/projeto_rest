import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_rest/firebase/getUsername.dart';
import 'package:projeto_rest/pages/page1.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:projeto_rest/storage/imageUpload.dart';
import 'package:projeto_rest/storage/storage_service.dart';
import 'package:projeto_rest/widgets/emailField.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;



class Page2 extends StatefulWidget {
  const Page2({ Key? key }) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser!;
  var dt = DateTime.now();
  String formattedTime = "";
  bool imagemEstado = false;

  

  void mandarEmail() async{
    if(user != null && !user.emailVerified){
      await user.sendEmailVerification();
      print("mandei email");
    }
  }
  
  Timer? timer;
  var x;


  @override
  void initState() {
    // TODO: implement initState
    
  
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }


  final storage = FirebaseStorage.instance;
  TextEditingController testeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //mandarEmail();
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(title: Text("LitBook"), centerTitle: true,),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${user.email}", textAlign: TextAlign.center,),
              Text("${user.displayName}", textAlign: TextAlign.center,),
              ElevatedButton(
                onPressed: () async{
                  //sair();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUpload(userId: user.uid,)));
                }, 
                child: Text("Deslogue com 1 click")
              ),
              ElevatedButton(
                onPressed: () async{
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg']
                  );
      
                  if (results == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Nenhum arquivo selecionado"))
                    );
                    return null;
                  }
                  final path = results.files.single.path!;
                  final fileName = results.files.single.name;
      
                  print(path);
                  print(fileName);
      
                  storage
                      .uploadFile(path, "${user.email}")
                      .then((value) {
                         print("Done");
                         
                         setState(() { // troca a imagem quando necessario p1
                           imagemEstado = !imagemEstado;
                         });
                      });
                }, 
                child: Text("Encontrar imagem"),
                
              ),
              imagemEstado == true ? // troca a imagem quando necessario p2
              FutureBuilder(
                future: storage.downloadURL('${user.email}'),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    print("parte1");
                    return Container(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  return Container();
                },
              )
              :
              FutureBuilder(
                future: storage.downloadURL('${user.email}'),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    return Container(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData){
                    print("parte2");
                    return CircularProgressIndicator();
                  }
                  return Container();
                },
              ),
                EmailField(controller: testeController, 
                hint: "", 
                label: "postar", 
                icon: Icons.post_add),
              ElevatedButton(
                onPressed: () async{
                  DateTime now = DateTime.now();
                  Future<void> addUser() {
                  // Call the user's CollectionReference to add a new user
                  print(now);
                  return users
                      /* .add({
                        'full_name': "guilherme lincoln", // John Doe
                        'company': "Lit", // Stokes and Sons
                        'age': 21, // 42
                        'postagem':testeController.text,
                        'hora': dt 
                      })
                      .then((value) => print("User Added"))
                      .catchError((error) => print("Failed to add user: $error")); */
                      .doc(now.toString())
                      .set
                      ({
                        'full_name': user.displayName, // John Doe
                        'company': "Lit", // Stokes and Sons
                        'age': 21, // 42
                        'postagem':testeController.text
                      })
                      .then((value) => print("User Added"))
                      .catchError((error) => print("Failed to add user: $error")); 
                    }
                  addUser();
              }, 
                child: Text("Poste no LitBook")),
              SingleChildScrollView(
                child: UserInformation(urlImagem: user.uid,),
              ) 
            ],
          ),
        ),
      )
    );
  }

  sair()async{
    await FirebaseAuth.instance.signOut().then((user) => Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => Page1())));
  }

}

