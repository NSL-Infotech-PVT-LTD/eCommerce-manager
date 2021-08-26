import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppTranslation {
  Locale? locale;

  static Map<dynamic, dynamic>? _localisedValues;

  AppTranslation(Locale locale) {
    this.locale = locale;
  //  _localisedValues = null;
  }

  static AppTranslation? of(BuildContext context) {
    return Localizations.of<AppTranslation>(context, AppTranslation);
  }

  static Future<AppTranslation> load(Locale locale) async {
    print("jugraj==> ${locale.languageCode}");
    AppTranslation appTranslations = AppTranslation(locale);
    String jsonContent = await rootBundle
        .loadString("assets/locale/localization_${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale!.languageCode;

  String text(String key) {
    return _localisedValues![key] ?? "$key not found";
  }
}
