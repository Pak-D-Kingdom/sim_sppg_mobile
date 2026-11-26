import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sim_sppg_mobile/features/cuti/main/domain/entities/cuti_tab_type.dart';
import 'package:sim_sppg_mobile/features/cuti/main/presentation/pages/main_cuti_page.dart';
import 'package:sim_sppg_mobile/injection_container.dart' as di;

void main() {
  setUp(() async {
    await di.sl.reset();
    await di.init();
  });

  testWidgets('IzinDarurat renders match mockup UI for Tidak Masuk and Izin Terlambat',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MainCutiPage(initialTab: CutiTabType.izinDarurat),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Ketentuan Izin Darurat Card
    expect(find.text('Ketentuan Izin Darurat'), findsOneWidget);
    expect(find.text('Tidak Potong Kuota'), findsOneWidget);
    expect(
      find.text(
        'Khusus kondisi mendesak hari-H (musibah keluarga, kendala perjalanan, atau bencana) tanpa memotong jatah cuti tahunan.',
      ),
      findsOneWidget,
    );

    // 2. Jenis & Waktu Darurat Card with sub-tabs
    expect(find.text('Jenis & Waktu Darurat'), findsOneWidget);
    expect(find.text('Tidak Masuk (Full)'), findsOneWidget);
    expect(find.text('Izin Terlambat'), findsOneWidget);

    // Default mode: Tidak Masuk (Full)
    expect(find.text('Tanggal Mulai'), findsOneWidget);
    expect(find.text('Tanggal Selesai'), findsOneWidget);
    expect(find.text('• Durasi: 1 Hari Kerja'), findsOneWidget);
    expect(find.text('Kuota Cuti: Tetap 5 Hari'), findsOneWidget);
    expect(find.text('Kirim Izin Darurat'), findsOneWidget);

    // 3. Card Kategori, Keterangan & Bukti
    expect(find.text('Kategori Kondisi Darurat'), findsOneWidget);
    expect(find.text('Keluarga Rawat Darurat'), findsOneWidget);
    expect(
      find.text(
        'Contoh: Keluarga rawat darurat, kendaraan mogok, banjir/bencana, dll.',
      ),
      findsOneWidget,
    );
    expect(find.text('Keterangan Singkat'), findsOneWidget);
    expect(find.text('Lampirkan Bukti'), findsOneWidget);
    expect(find.textContaining('Unggah foto kondisi di tempat'), findsOneWidget);

    // Footer notice
    expect(
      find.text(
        'Akan diteruskan sebagai prioritas ke Koordinator Unit SPPG\nRawamangun 01.',
      ),
      findsOneWidget,
    );

    // 4. Switch to Izin Terlambat
    await tester.tap(find.text('Izin Terlambat'));
    await tester.pumpAndSettle();

    // Check Izin Terlambat UI
    expect(find.text('Tanggal Shift'), findsOneWidget);
    expect(find.text('Estimasi Jam Tiba'), findsOneWidget);
    expect(find.text('06:15 WIB'), findsOneWidget);
    expect(find.text('Jadwal Masuk: 05:00 WIB'), findsOneWidget);
    expect(find.text('• Izin Terlambat: 75 Menit'), findsOneWidget);
    expect(
      find.text(
        'Estimasi tiba pukul 06:15 WIB (terlambat 1 jam 15 menit).\nWajib scan wajah saat tiba di dapur.',
      ),
      findsOneWidget,
    );
    expect(find.text('Kendaraan Mogok'), findsOneWidget);
    expect(find.text('Kirim Izin Terlambat'), findsOneWidget);
  });
}
