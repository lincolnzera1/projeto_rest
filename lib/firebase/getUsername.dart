import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_rest/storage/storage_service.dart';

class UserInformation extends StatefulWidget {

  String? urlImagem;

  UserInformation({ Key? key, required this.urlImagem}) : super(key: key); 

  @override
    _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  

  var lista = [];
  final Storage storage = Storage();
  bool imagemEstado = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        var l = ListView(
          reverse: true,
          
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          
            return ListTile(
              leading: Image.network("${widget.urlImagem}"),
              title: Text(data['postagem']),
              subtitle: Text(data['full_name']),
              
            );
          }).toList(),
        );
        lista.add(l);
        //print(lista);
        return Container(
          height: 200,
          child: l,
        );
      },
    );
  }
}