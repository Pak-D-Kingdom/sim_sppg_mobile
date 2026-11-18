import 'package:flutter_test/flutter_test.dart';
import 'package:sim_sppg_mobile/features/home/presentation/pages/home_page.dart';
import 'package:sim_sppg_mobile/injection_container.dart' as di;
import 'package:sim_sppg_mobile/main.dart';

void main() {
  setUp(() async {
    await di.sl.reset();
    await di.init();
  });

  testWidgets('MyApp smoke test - loads NutriOps SIM-SPPG HomePage elements',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(HomePage), findsOneWidget);

    await tester.pumpAndSettle();

    // Verify Top Bar & User Profile Card
    expect(find.text('SIM-SPPG'), findsOneWidget);
    expect(find.text('V2.0'), findsOneWidget);
    expect(find.text('SPPG Rawamangun Sentral 01'), findsOneWidget);
    expect(find.text('Siti Rahmawati, A.Md.Gz'), findsOneWidget);
    expect(find.text('Ahli Gizi & Pengawas Mutu Masak'), findsOneWidget);

    // Verify Operational Alert Banner
    expect(
      find.text('28 Nov 2026 — Pembersihan Menyeluruh & Pest Control Dapur'),
      findsOneWidget,
    );

    // Verify Today's Attendance Card
    expect(find.text('KEHADIRAN HARI INI'), findsOneWidget);
    expect(find.text('Shift Pagi (05:00 - 13:00 WIB)'), findsOneWidget);
    expect(find.text('Clock-Out Sekarang (Pulang)'), findsOneWidget);

    // Verify Layanan Mandiri Personel & Ringkasan Bulan Ini
    expect(find.text('Layanan Mandiri Personel'), findsOneWidget);
    expect(find.text('Presensi GPS'), findsOneWidget);
    expect(find.text('Ringkasan Bulan Ini'), findsOneWidget);
    expect(find.text('STANDAR MUTU SPPG'), findsOneWidget);
  });
}
