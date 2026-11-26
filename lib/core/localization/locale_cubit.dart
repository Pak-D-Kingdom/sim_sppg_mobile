import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit([Locale? initialLocale])
      : super(initialLocale ?? const Locale('id'));

  // shortcut: in-memory locale only, add shared_preferences when persistent language across restarts is required.
  void setLocale(Locale locale) {
    if (state != locale) {
      emit(locale);
    }
  }

  void switchToIndonesian() => setLocale(const Locale('id'));

  void switchToEnglish() => setLocale(const Locale('en'));
}
