import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_sppg_mobile/core/localization/app_localizations_extension.dart';
import 'package:sim_sppg_mobile/core/localization/locale_cubit.dart';
import 'package:sim_sppg_mobile/core/routes/app_router.dart';
import 'package:sim_sppg_mobile/core/routes/app_routes.dart';
import 'package:sim_sppg_mobile/injection_container.dart' as di;

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await di.sl.reset();
    await di.init();
  });

  group('LocaleCubit', () {
    test('initial locale is Indonesian (id)', () {
      final cubit = LocaleCubit();
      expect(cubit.state, const Locale('id'));
    });

    test('switchToEnglish changes state to Locale(en)', () {
      final cubit = LocaleCubit();
      cubit.switchToEnglish();
      expect(cubit.state, const Locale('en'));
    });

    test('switchToIndonesian changes state to Locale(id)', () {
      final cubit = LocaleCubit(const Locale('en'));
      cubit.switchToIndonesian();
      expect(cubit.state, const Locale('id'));
    });
  });

  testWidgets(
      'Ganti Bahasa feature toggles language between ID and EN dynamically',
      (WidgetTester tester) async {
    final localeCubit = LocaleCubit();

    await tester.pumpWidget(
      BlocProvider<LocaleCubit>.value(
        value: localeCubit,
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              locale: locale,
              localizationsDelegates:
                  AppLocalizationsConfig.localizationsDelegates,
              supportedLocales: AppLocalizationsConfig.supportedLocales,
              initialRoute: AppRoutes.akun,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Initial State: Indonesian
    expect(find.text('Profil'), findsOneWidget);
    expect(find.text('Ubah Kata Sandi'), findsOneWidget);
    expect(find.text('Ganti Bahasa'), findsOneWidget);
    expect(find.text('Keluar dari Akun'), findsOneWidget);

    // 2. Tap on 'Ganti Bahasa'
    await tester.ensureVisible(find.text('Ganti Bahasa'));
    await tester.tap(find.text('Ganti Bahasa'));
    await tester.pumpAndSettle();

    // Bottom sheet is shown
    expect(find.text('Pilih Bahasa'), findsOneWidget);
    expect(find.text('Bahasa Indonesia'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);

    // 3. Switch to English
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // Bottom sheet closed and language changed to English
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Change Password'), findsOneWidget);
    expect(find.text('Change Language'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);
    expect(localeCubit.state, const Locale('en'));

    // 4. Switch back to Indonesian
    await tester.ensureVisible(find.text('Change Language'));
    await tester.tap(find.text('Change Language'));
    await tester.pumpAndSettle();

    expect(find.text('Select Language'), findsOneWidget);
    await tester.tap(find.text('Indonesian'));
    await tester.pumpAndSettle();

    // Verifying it is back to Indonesian
    expect(find.text('Profil'), findsOneWidget);
    expect(find.text('Ubah Kata Sandi'), findsOneWidget);
    expect(find.text('Ganti Bahasa'), findsOneWidget);
    expect(find.text('Keluar dari Akun'), findsOneWidget);
    expect(localeCubit.state, const Locale('id'));
  });
}
