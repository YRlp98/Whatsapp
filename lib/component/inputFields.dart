import 'package:flutter/material.dart';

class InputFieldsArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;

  InputFieldsArea({this.hint, this.obscure, this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 0.5, color: Colors.white30))),
        child: TextFormField(
          obscureText: obscure,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
              contentPadding: const EdgeInsets.only(
                  top: 15, right: 0, bottom: 20, left: 5)),
        ));
  }
}
