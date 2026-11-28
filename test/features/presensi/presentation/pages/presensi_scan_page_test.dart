import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_sppg_mobile/core/localization/app_localizations_extension.dart';
import 'package:sim_sppg_mobile/features/main/presentation/pages/main_page.dart';
import 'package:sim_sppg_mobile/features/presensi/domain/entities/presensi_data.dart';
import 'package:sim_sppg_mobile/features/presensi/presentation/bloc/presensi_bloc.dart';
import 'package:sim_sppg_mobile/features/presensi/presentation/bloc/presensi_event.dart';
import 'package:sim_sppg_mobile/features/presensi/presentation/pages/presensi_scan_page.dart';
import 'package:sim_sppg_mobile/injection_container.dart' as di;

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await di.sl.reset();
    await di.init();
  });

  testWidgets(
      'PresensiScanPage starts with camera off and enables confirm only after capture',
      (WidgetTester tester) async {
    final bloc = di.sl<PresensiBloc>()
      ..add(const LoadPresensiStatusEvent(requestedType: PresensiType.clockIn));

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('id'),
        localizationsDelegates: AppLocalizationsConfig.localizationsDelegates,
        supportedLocales: AppLocalizationsConfig.supportedLocales,
        home: BlocProvider.value(
          value: bloc,
          child: const PresensiScanPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Camera is off by default -> shows "Hidupkan Kamera"
    expect(find.text('Hidupkan Kamera'), findsOneWidget);

    // Confirm button is disabled before capture
    final confirmFinder = find.widgetWithText(
      ElevatedButton,
      'Konfirmasi Clock-In (Masuk)',
    );
    expect(confirmFinder, findsOneWidget);
    expect(tester.widget<ElevatedButton>(confirmFinder).onPressed, isNull);

    // Simulate photo captured
    bloc.add(const CaptureFacePhotoEvent('/tmp/test_selfie.jpg'));
    await tester.pumpAndSettle();

    // Now Retake appears and Confirm is enabled
    expect(find.text('Foto Ulang'), findsOneWidget);
    expect(tester.widget<ElevatedButton>(confirmFinder).onPressed, isNotNull);

    // Tap confirm -> transitions to Clock-Out with fresh camera-off state
    await tester.ensureVisible(confirmFinder);
    await tester.tap(confirmFinder);
    await tester.pumpAndSettle();

    expect(find.text('Presensi Pulang'), findsOneWidget);
    expect(find.text('Hidupkan Kamera'), findsOneWidget);
    final confirmOutFinder = find.widgetWithText(
      ElevatedButton,
      'Konfirmasi Clock-Out (Pulang)',
    );
    expect(tester.widget<ElevatedButton>(confirmOutFinder).onPressed, isNull);

    await bloc.close();
  });

  testWidgets(
      'Home Clock-Out button switches to Presensi tab without pushing a new route',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('id'),
        localizationsDelegates: AppLocalizationsConfig.localizationsDelegates,
        supportedLocales: AppLocalizationsConfig.supportedLocales,
        home: MainPage(),
      ),
    );
    await tester.pumpAndSettle();

    // Tap Clock-Out button on Home
    final clockOutBtn = find.text('Clock-Out Sekarang (Pulang)');
    expect(clockOutBtn, findsOneWidget);
    await tester.ensureVisible(clockOutBtn);
    await tester.tap(clockOutBtn);
    await tester.pumpAndSettle();

    // Single PresensiScanPage shown inside MainPage (no back button pushed)
    expect(find.text('Presensi Pulang'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsNothing);
    expect(find.text('Hidupkan Kamera'), findsOneWidget);
  });
}
