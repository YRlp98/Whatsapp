import 'package:flutter/material.dart';
import 'package:whatsapp/all_translation.dart';
import 'package:whatsapp/pages/camera_screen.dart';
import 'package:whatsapp/pages/image_picker_screen.dart';
import 'package:whatsapp/pages/login_screen.dart';
import 'package:whatsapp/pages/select_language_screen.dart';
import 'package:whatsapp/pages/splash_screen.dart';
import 'package:whatsapp/translations.dart';
import 'whatsapp_home.dart';
import 'package:whatsapp/pages/settings_screen.dart';
import 'package:whatsapp/pages/create-chat_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{
  await allTranslations.init('fa');
  runApp(MyApp());
}

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
