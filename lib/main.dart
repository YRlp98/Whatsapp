import 'package:flutter/material.dart';
import 'package:whatsapp/all_translation.dart';
import 'package:whatsapp/pages/camera_screen.dart';
import 'package:whatsapp/pages/login_screen.dart';
import 'package:whatsapp/pages/select_language_screen.dart';
import 'package:whatsapp/pages/splash_screen.dart';
import 'whatsapp_home.dart';
import 'package:whatsapp/pages/settings_screen.dart';
import 'package:whatsapp/pages/create-chat_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  await allTranslations.init('fa');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print("onMessage: $message");
    }, onLaunch: (Map<String, dynamic> message) {
      print("onLaunch: $message");
    }, onResume: (Map<String, dynamic> message) {
      print("onResume: $message");
    });

    _firebaseMessaging.getToken().then((String token) {
      print("token: $token");
    });
  }

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
//        TranslationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],

//      supportedLocales: [const Locale('en', ''), const Locale("fa" '')],
      supportedLocales: allTranslations.supportedLocales(),

      routes: {
        '/': (context) => new Directionality(
            textDirection: TextDirection.rtl, child: new SplashScreen()),
//        '/': (context) => new Directionality(
//            textDirection: TextDirection.rtl, child: new ImagePickerScreen()),
//        '/': (context) => new Directionality(
//            textDirection: TextDirection.rtl, child: new SocketIoScreen()),
        '/login_screen': (context) => prepareScreen(new LoginScreen()),
        '/home': (context) => prepareScreen(new WhatsAppHome()),
        '/camera': (context) => prepareScreen(new CameraScreen()),
        '/settings': (context) => prepareScreen(new SettingsScreen()),
        '/settings/select_language': (context) =>
            prepareScreen(new SelectLanguageScreen()),
        '/new_chat': (context) => prepareScreen(new CreateChatScreen())
      },
      debugShowCheckedModeBanner: false,
//        home: Directionality(
//            textDirection: TextDirection.rtl, child: WhatsAppHome())
    );
  }

  prepareScreen(Widget screen,
      [TextDirection textDirection = TextDirection.rtl]) {
    return new Directionality(textDirection: TextDirection.rtl, child: screen);
  }
}
