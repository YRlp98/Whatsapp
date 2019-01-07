import 'package:flutter/material.dart';
import 'package:whatsapp/pages/login_screen.dart';
import 'package:whatsapp/pages/splash_screen.dart';
import 'whatsapp_home.dart';
import 'package:whatsapp/pages/settings_screen.dart';
import 'package:whatsapp/pages/create-chat_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp',
      theme: ThemeData(
          fontFamily: 'Vazir',
          primaryColor: Color(0xff075e54),
          accentColor: Color(0xff25d366)),
      initialRoute: 'splash_screen',
      routes: {
        '/': (context) => Directionality(
            textDirection: TextDirection.rtl, child: WhatsAppHome()),
        'login_screen': (context) => Directionality(
            textDirection: TextDirection.rtl, child: LoginScreen()),
        'splash_screen': (context) => Directionality(
            textDirection: TextDirection.rtl, child: SplashScreen()),
        '/settings': (context) => SettingsScreen(),
        '/new_chat': (context) => CreateChatScreen(),
      },
      debugShowCheckedModeBanner: false,
//        home: Directionality(
//            textDirection: TextDirection.rtl, child: WhatsAppHome())
    );
  }
}
