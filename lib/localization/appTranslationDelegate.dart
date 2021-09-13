import 'package:flutter/cupertino.dart';
import 'package:funfy_scanner/localization/Application.dart';
import 'package:funfy_scanner/localization/localaProvider.dart';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslation> {
  final Locale? newlocale;

  const AppTranslationsDelegate({this.newlocale});

  @override
  bool isSupported(Locale locale) {

    return application.supportedLanguagesCodes.contains(locale.languageCode); // return ["en", "es"].contains(locale.languageCode);
  }

  @override
  Future<AppTranslation> load(Locale locale) {
    print("Dur locale ${locale.languageCode}");

    return AppTranslation.load(newlocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslation> old) {
    return true;
  }
}
