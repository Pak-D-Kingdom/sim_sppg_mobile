import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'generated/app_localizations.dart';

export 'generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n =>
      AppLocalizations.of(this) ?? lookupAppLocalizations(const Locale('id'));
}

class AppLocalizationsConfig {
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    ...GlobalMaterialLocalizations.delegates,
  ];

  static const List<Locale> supportedLocales = AppLocalizations.supportedLocales;
}
