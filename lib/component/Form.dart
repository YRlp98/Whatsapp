import 'package:flutter/material.dart';
import 'inputFields.dart';
import 'package:validators/validators.dart';

class FormContainer extends StatelessWidget {
  final formKey;

  FormContainer({@required this.formKey});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                    hint: 'ایمیل کاربر',
                    obscure: false,
                    icon: Icons.person_outline,
                    validator: (String value) {
                      if (!isEmail(value)) {
                        return 'لطفا ایمیل را بصورت صحصح وارد نمایید!';
                      }
                    },
                  ),
                  InputFieldsArea(
                    hint: 'رمز عبور',
                    obscure: true,
                    icon: Icons.lock_outline,
                    validator: (String value) {
                      if (value.length < 5) {
                        return 'طول پسورد باید بیش تر از 6 کارکتر باشد!';
                      }
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }
}
