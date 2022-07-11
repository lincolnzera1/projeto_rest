import 'package:flutter/material.dart';

import '../styles/textStyles.dart';


class ButtonWidget extends StatelessWidget {

  final VoidCallback onClick;
  final String? label;
  const ButtonWidget({ Key? key, required this.onClick, required this.label }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      
      child: Ink(
        height: 60,
        width: 300,
        color: Color.fromARGB(255, 162, 221, 35),
        child: InkWell(
          onTap: onClick,
          child: Center(child: Text("$label", style: botao, )),
        ),
      ),
    );
  }
}