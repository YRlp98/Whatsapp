import 'package:flutter/material.dart';
import 'package:whatsapp/all_translation.dart';
import 'inputFields.dart';
import 'package:validators/validators.dart';

class FormContainer extends StatelessWidget {
  final formKey;
  final emailOnSaved;
  final passwordOnSaved;

  FormContainer(
      {@required this.formKey, this.emailOnSaved, this.passwordOnSaved});

  @override
  Widget build(BuildContext context) {
    print(allTranslations.currentLanguage);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  InputFieldsArea(
                      hint: allTranslations.text("email"),
                      obscure: false,
                      icon: Icons.person_outline,
                      validator: (String value) {
                        if (!isEmail(value)) {
                          return 'لطفا ایمیل را بصورت صحصح وارد نمایید!';
                        }
                      },
                      onSaved: emailOnSaved),
                  InputFieldsArea(
                      hint: allTranslations.text("password"),
                      obscure: true,
                      icon: Icons.lock_outline,
                      validator: (String value) {
                        if (value.length < 5) {
                          return 'طول پسورد باید بیش تر از 6 کارکتر باشد!';
                        }
                      },
                      onSaved: passwordOnSaved)
                ],
              ))
        ],
      ),
    );
  }
}
