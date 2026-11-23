import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sim_sppg_mobile/core/routes/app_router.dart';
import 'package:sim_sppg_mobile/core/routes/app_routes.dart';
import 'package:sim_sppg_mobile/injection_container.dart' as di;

void main() {
  setUp(() async {
    await di.sl.reset();
    await di.init();
  });

  testWidgets('RiwayatAbsenPage renders mockup UI and supports filtering/expand',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        initialRoute: AppRoutes.riwayatAbsen,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
    await tester.pumpAndSettle();

    // Header & Month Selector
    expect(find.text('Riwayat Absen'), findsOneWidget);
    expect(find.text('November 2026'), findsOneWidget);

    // 4 Summary Stat Cards
    expect(find.text('HADIR'), findsOneWidget);
    expect(find.text('15'), findsOneWidget);
    expect(find.text('TELAT'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('CUTI/IZIN'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('MENUNGGU'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    // Segmented Filter Tabs
    expect(find.text('Semua'), findsOneWidget);
    expect(find.text('Hadir'), findsOneWidget);
    expect(find.text('Telat'), findsOneWidget);
    expect(find.text('Cuti & Izin'), findsOneWidget);

    // 5 Visible Initial Cards matching mockup
    expect(find.text('Jum, 20 Nov 2026'), findsOneWidget);
    expect(find.text('Menunggu ACC'), findsOneWidget);
    expect(find.text('Bukti dokter belum diunggah (Sisa 47j)'), findsOneWidget);
    expect(find.text('Unggah →'), findsOneWidget);

    expect(find.text('Kam, 19 Nov 2026'), findsOneWidget);
    expect(find.text('Durasi: 8j 10m'), findsOneWidget);

    expect(find.text('Rab, 18 Nov 2026'), findsOneWidget);
    expect(find.text('Telat 12 Menit'), findsOneWidget);
    expect(find.text('Ajukan Koreksi'), findsOneWidget);

    expect(find.text('Sel, 17 Nov 2026'), findsOneWidget);
    expect(find.text('Cuti Disetujui'), findsOneWidget);

    expect(find.text('Sen, 16 Nov 2026'), findsOneWidget);
    expect(find.text('Durasi: 8j 06m'), findsOneWidget);

    // Bottom Expand Button
    expect(find.text('Tampilkan Semua di Bulan Ini (20)  ↓'), findsOneWidget);

    // Filter by Telat
    await tester.tap(find.text('Telat'));
    await tester.pumpAndSettle();
    expect(find.text('Rab, 18 Nov 2026'), findsOneWidget);
    expect(find.text('Jum, 20 Nov 2026'), findsNothing);
  });
}
