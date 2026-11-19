import 'package:flutter_test/flutter_test.dart';
import 'package:sim_sppg_mobile/features/home/presentation/pages/home_page.dart';
import 'package:sim_sppg_mobile/features/main/presentation/widgets/main_bottom_nav_widget.dart';
import 'package:sim_sppg_mobile/injection_container.dart' as di;
import 'package:sim_sppg_mobile/main.dart';

void main() {
  setUp(() async {
    await di.sl.reset();
    await di.init();
  });

  testWidgets(
      'MyApp smoke test - loads modern Clinical Flow SIM-SPPG Dashboard elements',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(HomePage), findsOneWidget);

    await tester.pumpAndSettle();

    // Verify Top Bar with User Identity & Location Badge
    expect(find.text('SPPG Rawamangun 01'), findsOneWidget);
    expect(find.text('Siti Rahmawati, A.Md.Gz'), findsOneWidget);

    // Verify Today's Attendance Card (Soft Blue Card)
    expect(find.text('Rabu, 20 November 2026'), findsOneWidget);
    expect(find.text('Shift Pagi (05:00 - 13:00 WIB)'), findsOneWidget);
    expect(find.text('CLOCK-IN'), findsOneWidget);
    expect(find.text('CLOCK-OUT'), findsOneWidget);
    expect(find.text('04:52'), findsOneWidget);
    expect(find.text('Tepat Waktu'), findsOneWidget);
    expect(find.text('Menunggu'), findsOneWidget);
    expect(find.text('Clock-Out Sekarang (Pulang)'), findsOneWidget);

    // Verify Layanan Mandiri Personel (6 Modul Utama)
    expect(find.text('Layanan Mandiri Personel'), findsOneWidget);
    expect(find.text('6 Modul Utama'), findsOneWidget);
    expect(find.text('Presensi GPS'), findsOneWidget);
    expect(find.text('Koreksi Absen'), findsOneWidget);
    expect(find.text('Ajukan Cuti'), findsOneWidget);
    expect(find.text('Jadwal & Libur'), findsOneWidget);
    expect(find.text('Slip Payroll'), findsOneWidget);
    expect(find.text('Approval Tim'), findsOneWidget);

    // Verify Ringkasan Bulan Ini
    expect(find.text('Ringkasan Bulan Ini'), findsOneWidget);
    expect(find.text('November 2026'), findsOneWidget);
    expect(find.text('Saldo Cuti'), findsOneWidget);
    expect(find.text('Kehadiran'), findsOneWidget);
    expect(find.text('Denda Telat'), findsOneWidget);
  });

  testWidgets(
      'MainBottomNavWidget highlights and navigates through modern clinical tabs',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify bottom nav items are present via tooltips/icons
    expect(find.byType(MainBottomNavWidget), findsOneWidget);
    expect(find.byTooltip('Beranda'), findsOneWidget);
    expect(find.byTooltip('Jadwal'), findsOneWidget);
    expect(find.byTooltip('Presensi'), findsOneWidget);
    expect(find.byTooltip('Payroll'), findsOneWidget);
    expect(find.byTooltip('Akun'), findsOneWidget);

    // Tap on center 'Presensi' floating action button
    await tester.tap(find.byTooltip('Presensi'));
    await tester.pumpAndSettle();

    // Verify placeholder screen for Presensi is shown
    expect(find.text('Presensi Scan (QR & GPS)'), findsOneWidget);

    // Tap back on 'Beranda' icon
    await tester.tap(find.byTooltip('Beranda'));
    await tester.pumpAndSettle();

    // Verify Dashboard elements are visible again
    expect(find.text('Siti Rahmawati, A.Md.Gz'), findsOneWidget);
    expect(find.text('Layanan Mandiri Personel'), findsOneWidget);
  });
}
