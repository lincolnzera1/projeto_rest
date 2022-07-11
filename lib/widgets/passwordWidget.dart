import 'package:flutter/material.dart';
import 'package:projeto_rest/widgets/textfields.dart';


class PasswordWidget extends StatefulWidget {
  final TextEditingController senhaController;
  const PasswordWidget({ Key? key, required this.senhaController }) : super(key: key);

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Senha",
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        )
      ),
      controller: widget.senhaController,
    );
  }
}