import 'package:flutter/material.dart';
import 'inputFields.dart';

class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Form(
              child: Column(
            children: <Widget>[
              InputFieldsArea(
                hint: 'ایمیل کاربر',
                obscure: false,
                icon: Icons.person_outline,
              ),
              InputFieldsArea(
                hint: 'رمز عبور',
                obscure: true,
                icon: Icons.lock_outline,
              )
            ],
          ))
        ],
      ),
    );
  }
}
