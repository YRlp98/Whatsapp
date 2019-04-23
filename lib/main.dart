import 'package:flutter/material.dart';
import 'package:whatsapp/pages/camera_screen.dart';
import 'package:whatsapp/pages/image_picker_screen.dart';
import 'package:whatsapp/pages/login_screen.dart';
import 'package:whatsapp/pages/splash_screen.dart';
import 'package:whatsapp/translations.dart';
import 'whatsapp_home.dart';
import 'package:whatsapp/pages/settings_screen.dart';
import 'package:whatsapp/pages/create-chat_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
//      initialRoute: 'splash_screen',
      localizationsDelegates: [
        TranslationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],

      supportedLocales: [const Locale('en', ''), const Locale("fa" '')],

      routes: {
        '/': (context) => new Directionality(
            textDirection: TextDirection.rtl, child: new SplashScreen()),
//        '/': (context) => new Directionality(
//            textDirection: TextDirection.rtl, child: new ImagePickerScreen()),
//        '/': (context) => new Directionality(
//            textDirection: TextDirection.rtl, child: new SocketIoScreen()),
        '/login_screen': (context) => new Directionality(
            textDirection: TextDirection.rtl, child: new LoginScreen()),
        '/home': (context) => new Directionality(
            textDirection: TextDirection.rtl, child: new WhatsAppHome()),
        '/camera': (context) => new Directionality(
            textDirection: TextDirection.rtl, child: new CameraScreen()),
        '/settings': (context) => new SettingsScreen(),
        '/new_chat': (context) => new CreateChatScreen(),
      },
      debugShowCheckedModeBanner: false,
//        home: Directionality(
//            textDirection: TextDirection.rtl, child: WhatsAppHome())
    );
  }
}
