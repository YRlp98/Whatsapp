import 'package:flutter/material.dart';
import 'package:whatsapp/animations/signin_animation.dart';
import 'package:whatsapp/component/Form.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _loginButtonController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginButtonController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    timeDilation = .4;
    var page = MediaQuery.of(context).size;

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: <Color>[
          const Color(0xff2c5364),
          const Color(0xff0f2027)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: new Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            new Opacity(
              opacity: .3,
              child: new Container(
                width: page.width,
                height: page.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/icon_background.png"),
                        repeat: ImageRepeat.repeat)),
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new FormContainer(formKey: _formKey),
                new FlatButton(
                    onPressed: null,
                    child: Text(
                      "آیا هیچ اکانتی ندارید؟ عضویت",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.5,
                          color: Colors.white,
                          fontSize: 14),
                    ))
              ],
            ),
            new GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  print('Do STH');
                }
                await _loginButtonController.forward();
                await _loginButtonController.reverse();
              },
              child:
                  new SignInAnimation(controller: _loginButtonController.view),
            )
          ],
        ),
      ),
    );
  }
}
