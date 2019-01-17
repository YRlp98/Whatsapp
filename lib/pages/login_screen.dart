import 'package:flutter/material.dart';
import 'package:whatsapp/animations/signin_animation.dart';
import 'package:whatsapp/component/Form.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:whatsapp/services/auth_services.dart';

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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _emailValue;
  String _passwordValue;

  emailOnSaved(String value) {
    _emailValue = value;
  }

  passwordOnSaved(String value) {
    _passwordValue = value;
  }

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
      key: _scaffoldKey,
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
                new FormContainer(
                    formKey: _formKey,
                    emailOnSaved: emailOnSaved,
                    passwordOnSaved: passwordOnSaved),
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
                  _formKey.currentState.save();
                  sendDataForLogin();
                }
              },
              child:
                  new SignInAnimation(controller: _loginButtonController.view),
            )
          ],
        ),
      ),
    );
  }

  void sendDataForLogin() async {
    await _loginButtonController.animateTo(0.150);
    Map response = await (new AuthService())
        .sendDataToLogin({'email': _emailValue, 'password': _passwordValue});

    if (response['status'] == 'success') {
      await _loginButtonController.forward();
      Navigator.pushReplacementNamed(context, '/');
    } else {
      await _loginButtonController.reverse();
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
        response['data'],
        style: new TextStyle(fontFamily: 'Vazir'),
      )));
    }
  }
}
