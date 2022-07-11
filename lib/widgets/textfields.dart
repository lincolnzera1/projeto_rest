import 'package:flutter/material.dart';
import 'package:projeto_rest/styles/textStyles.dart';


Widget campoDeEmail(){
  return const TextField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: "teste@gmail.com",
      labelText: "Email",
      prefixIcon: Icon(Icons.email),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        borderSide: BorderSide(width: 3),
      ),
    ),
  );
}

Widget campoDeSenha(){
  return const TextField(
    obscureText: true,
    decoration: InputDecoration(
      labelText: "Senha",
      prefixIcon: Icon(Icons.email),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      )
    ),
  );
}

Widget botaoLogin(){
  return Material(
    color: Colors.transparent,
    clipBehavior: Clip.hardEdge,
    borderRadius: BorderRadius.all(Radius.circular(24.0)),
    child: Ink(
      height: 60,
      width: 300,
      color: Color.fromARGB(255, 162, 221, 35),
      child: InkWell(
        onTap: () {
          
        },
        child: Center(child: Text("Login", style: botao, )),
      ),
    ),
  );
}