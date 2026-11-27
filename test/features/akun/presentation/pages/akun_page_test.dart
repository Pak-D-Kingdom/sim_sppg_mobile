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

  testWidgets('AkunPage renders profile mockup UI and navigates to sub-routes',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        initialRoute: AppRoutes.akun,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
    await tester.pumpAndSettle();

    // Header
    expect(find.text('Profil'), findsOneWidget);
    expect(find.text('Informasi kepegawaian & pengaturan akun'), findsOneWidget);

    // Hero Card
    expect(find.text('Siti Rahmawati, A.Md.Gz'), findsOneWidget);
    expect(find.text('Ahli Gizi • Pelaksana Gizi'), findsOneWidget);
    expect(find.text('SPPG Rawamangun 01'), findsOneWidget);
    expect(find.text('ID PERSONEL'), findsOneWidget);
    expect(find.text('SPPG-RMG-014'), findsOneWidget);
    expect(find.text('MASA KERJA'), findsOneWidget);
    expect(find.text('1 Thn 4 Bln'), findsOneWidget);

    // Detail Akun Button (replaces Data Kepegawaian & Payroll card)
    expect(find.text('Detail Akun'), findsOneWidget);
    expect(find.text('Data kepegawaian, penempatan & payroll'), findsOneWidget);

    // Settings & Logout
    expect(find.text('Ubah Kata Sandi'), findsOneWidget);
    expect(find.text('Pusat Bantuan & SOP'), findsOneWidget);
    expect(find.text('Keluar dari Akun'), findsOneWidget);
    expect(
      find.text('SIM-SPPG Mobile v2.4.0 • Badan Gizi Nasional'),
      findsOneWidget,
    );

    // Navigate to Detail Akun (Data Kepegawaian & Payroll)
    await tester.ensureVisible(find.text('Detail Akun'));
    await tester.tap(find.text('Detail Akun'));
    await tester.pumpAndSettle();
    expect(find.text('Data Kepegawaian & Payroll'), findsOneWidget);
    expect(find.text('Personel Aktif'), findsOneWidget);
    expect(find.text('IDENTITAS PRIBADI & KONTAK'), findsOneWidget);
    expect(find.text('3175025408980004'), findsOneWidget);
    expect(find.text('Jakarta, 14 Agu 1998'), findsOneWidget);
    expect(find.text('siti.rahmawati@sppg.go.id'), findsOneWidget);
    expect(find.text('0812-8490-3321'), findsOneWidget);
    expect(find.text('Rawamangun, Jakarta Timur'), findsOneWidget);
    expect(find.text('PENEMPATAN & JADWAL SHIFT'), findsOneWidget);
    expect(find.text('Gizi & Pengawasan Mutu'), findsOneWidget);
    expect(find.text('01 Agustus 2025'), findsOneWidget);
    expect(find.text('Shift Pagi (05:00 - 13:00)'), findsOneWidget);
    expect(find.text('REKENING PAYROLL & JAMINAN'), findsOneWidget);
    expect(find.text('Terverifikasi'), findsOneWidget);
    expect(find.text('Bank Rakyat Indonesia (BRI)'), findsOneWidget);
    expect(find.text('0341-01-048291-50-9'), findsOneWidget);
    expect(find.text('SITI RAHMAWATI'), findsOneWidget);
    expect(find.text('Aktif • Ditanggung Lembaga'), findsOneWidget);

    // Pop back to AkunPage
    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Detail Akun'), findsOneWidget);

    // Navigate to Ubah Kata Sandi
    await tester.ensureVisible(find.text('Ubah Kata Sandi'));
    await tester.tap(find.text('Ubah Kata Sandi'));
    await tester.pumpAndSettle();
    expect(find.text('Simpan Kata Sandi Baru'), findsOneWidget);

    // Pop back & navigate to Pusat Bantuan & SOP
    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Pusat Bantuan & SOP'));
    await tester.tap(find.text('Pusat Bantuan & SOP'));
    await tester.pumpAndSettle();
    expect(find.text('SOP Presensi Biometrik & Radius GPS'), findsOneWidget);
  });
}
