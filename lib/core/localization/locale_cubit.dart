import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String localePrefKey = 'APP_LOCALE';

  final SharedPreferences? _prefs;

  LocaleCubit([Locale? initialLocale, SharedPreferences? prefs])
      : _prefs = prefs,
        super(
          initialLocale ?? _readSavedLocale(prefs) ?? const Locale('id'),
        );

  static Locale? _readSavedLocale(SharedPreferences? prefs) {
    final code = prefs?.getString(localePrefKey);
    if (code == 'id' || code == 'en') {
      return Locale(code!);
    }
    return null;
  }

  void setLocale(Locale locale) {
    if (state != locale) {
      emit(locale);
      _prefs?.setString(localePrefKey, locale.languageCode);
    }
  }

  void switchToIndonesian() => setLocale(const Locale('id'));

  void switchToEnglish() => setLocale(const Locale('en'));
}
