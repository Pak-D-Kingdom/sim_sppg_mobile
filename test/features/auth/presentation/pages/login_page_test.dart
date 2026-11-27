import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_sppg_mobile/core/routes/app_router.dart';
import 'package:sim_sppg_mobile/core/routes/app_routes.dart';
import 'package:sim_sppg_mobile/injection_container.dart' as di;

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await di.sl.reset();
    await di.init();
  });

  testWidgets(
      'LoginPage renders mockup UI without register and navigates properly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
    await tester.pumpAndSettle();

    // Header branding
    expect(find.text('BADAN GIZI NASIONAL'), findsOneWidget);
    expect(find.text('SIM-SPPG'), findsOneWidget);
    expect(
      find.text(
        'Sistem Informasi Manajemen Satuan Pelayanan\nPemenuhan Gizi',
      ),
      findsOneWidget,
    );

    // Login card content
    expect(find.text('Masuk ke Akun'), findsOneWidget);
    expect(
      find.text('Gunakan ID Personel atau email resmi yang terdaftar'),
      findsOneWidget,
    );
    expect(find.text('ID Personel / Email'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);
    expect(find.text('Ingat sesi saya'), findsOneWidget);
    expect(find.text('Lupa kata sandi?'), findsOneWidget);
    expect(find.text('Masuk  →'), findsOneWidget);

    // Info notice & footer (no register)
    expect(
      find.text(
        'Akun personel diterbitkan & dikelola oleh Admin Unit SPPG. Hubungi KSPPG jika belum memiliki akses.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('SIM-SPPG Mobile v2.4.0 • Badan Gizi Nasional'),
      findsOneWidget,
    );
    expect(find.textContaining('Daftar'), findsNothing);
    expect(find.textContaining('Register'), findsNothing);

    // Navigate to Lupa Kata Sandi route
    await tester.tap(find.text('Lupa kata sandi?'));
    await tester.pumpAndSettle();
    expect(find.text('Lupa Kata Sandi'), findsOneWidget);
    expect(find.text('Pemulihan Akses Personel'), findsOneWidget);

    // Back to Login
    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Masuk ke Akun'), findsOneWidget);
  });
}
