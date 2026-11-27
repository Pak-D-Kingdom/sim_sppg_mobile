import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_sppg_mobile/core/theme/app_theme.dart';
import 'package:sim_sppg_mobile/features/notification/presentation/pages/notification_page.dart';
import 'package:sim_sppg_mobile/injection_container.dart' as di;

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await di.sl.reset();
    await di.init();
  });

  testWidgets(
      'NotificationPage loads all design elements matching UI mockup',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const NotificationPage(),
      ),
    );

    // Initial pump
    await tester.pump();
    await tester.pumpAndSettle();

    // Verify Title and Action
    expect(find.text('Notifikasi'), findsOneWidget);
    expect(find.text('Tandai dibaca'), findsOneWidget);

    // Verify Filter Tabs
    expect(find.text('Semua (2)'), findsOneWidget);
    expect(find.text('Operasional'), findsOneWidget);
    expect(find.text('Persetujuan'), findsOneWidget);

    // Verify Section Header
    expect(find.text('HARI INI'), findsOneWidget);
    expect(find.text('3 Pesan'), findsOneWidget);

    // Verify Notification Cards
    expect(
      find.text('28 Nov 2026 — Pembersihan Menyeluruh & Pest Control Dapur'),
      findsOneWidget,
    );
    expect(
      find.text('Pengajuan Cuti Menunggu Persetujuan'),
      findsOneWidget,
    );
    expect(
      find.text('Clock-In Berhasil (Tepat Waktu)'),
      findsOneWidget,
    );

    // Verify Status indicators
    expect(find.text('Belum dibaca'), findsNWidgets(2));
    expect(find.text('Sudah dibaca'), findsOneWidget);

    // Test tap on "Tandai dibaca"
    await tester.tap(find.text('Tandai dibaca'));
    await tester.pumpAndSettle();

    // Verify all marked as read
    expect(find.text('Semua'), findsOneWidget);
    expect(find.text('Sudah dibaca'), findsNWidgets(3));
  });

  testWidgets(
      'NotificationPage filters items when filter chip is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const NotificationPage(),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    // Tap on "Persetujuan"
    await tester.tap(find.text('Persetujuan'));
    await tester.pumpAndSettle();

    // Should only show 1 message
    expect(find.text('1 Pesan'), findsOneWidget);
    expect(find.text('PENGAJUAN CUTI'), findsOneWidget);
    expect(find.text('PERINGATAN OPERASIONAL'), findsNothing);
  });
}
