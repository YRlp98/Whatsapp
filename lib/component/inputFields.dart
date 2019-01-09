import 'package:flutter/material.dart';

class InputFieldsArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final validator;

  InputFieldsArea({this.hint, this.obscure, this.icon, this.validator});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          validator: validator,
          obscureText: obscure,
          style: new TextStyle(color: Colors.white),
          decoration: new InputDecoration(
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              enabledBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white30)),
              focusedBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white)),
              errorStyle: new TextStyle(color: Colors.amber),
              errorBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.amber)),
              focusedErrorBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.amber)),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
              contentPadding: const EdgeInsets.only(
                  top: 15, right: 0, bottom: 20, left: 5)),
        ));
  }
}
