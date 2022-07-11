import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';


class EmailField extends StatefulWidget {

  final TextEditingController controller;
  final String? hint;
  final String? label;
  final IconData icon;

  const EmailField({ Key? key, required this.controller, required this.hint, required this.label, required this.icon }) : super(key: key);

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) => TextFormField(
    keyboardType: TextInputType.emailAddress,
    autofillHints: [AutofillHints.email],
    decoration: InputDecoration(
      hintText: widget.hint,
      labelText: widget.label,
      prefixIcon: Icon(widget.icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        borderSide: BorderSide(width: 3),
      ),
    ),
    controller: widget.controller,
    validator: (email) => email != null && !EmailValidator.validate(email)
      ? "Enter a valid Email"
      : null
    ,
  );
}