import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Translations {
  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    return _localizedValues[key] ?? '** $key not found!';
  }

  static Future<Translations> load(locale) async {
    Translations translations = new Translations(locale);

    String jsonContent =
        await rootBundle.loadString("locale/i18n_${locale.languageCode}.json");

    _localizedValues = json.decode(jsonContent);

    return translations;
  }

  get currentLanguage => locale.languageCode;
}

class TranslationDelegate extends LocalizationsDelegate<Translations> {
  @override
  bool isSupported(Locale locale) => ['en', 'fa'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => false;
}
