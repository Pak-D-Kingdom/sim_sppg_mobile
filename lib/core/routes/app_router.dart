import 'package:material_ui/material_ui.dart';
import '../constants/app_colors.dart';
import '../../features/jadwal/presentation/pages/jadwal_page.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/notification/presentation/pages/notification_page.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.main:
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
          settings: settings,
        );

      case AppRoutes.notification:
        return MaterialPageRoute(
          builder: (_) => const NotificationPage(),
          settings: settings,
        );

      case AppRoutes.riwayatAbsen:
        return MaterialPageRoute(
          builder: (_) => const _ModulePlaceholderScreen(
            title: 'Riwayat Absen',
            description:
                'Rekap log presensi clock-in & clock-out dapur sentral.',
            icon: Icons.history_rounded,
          ),
          settings: settings,
        );

      case AppRoutes.ajukanCuti:
        return MaterialPageRoute(
          builder: (_) => const _ModulePlaceholderScreen(
            title: 'Ajukan Cuti',
            description:
                'Formulir pengajuan cuti tahunan, sakit, dan izin dinas.',
            icon: Icons.calendar_today_outlined,
          ),
          settings: settings,
        );

      case AppRoutes.jadwal:
        return MaterialPageRoute(
          builder: (_) => const JadwalPage(),
          settings: settings,
        );

      case AppRoutes.payroll:
        return MaterialPageRoute(
          builder: (_) => const _ModulePlaceholderScreen(
            title: 'Slip Payroll',
            description:
                'Rincian gaji bulanan, transparansi denda keterlambatan, dan insentif mutu.',
            icon: Icons.payments_outlined,
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Halaman Tidak Ditemukan'),
            ),
            body: Center(
              child: Text(
                'Rute "${settings.name}" belum terdaftar di AppRouter.',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
          settings: settings,
        );
    }
  }
}

class _ModulePlaceholderScreen extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _ModulePlaceholderScreen({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.onSurface,
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 38,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.secondarySoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Modul Siap Terintegrasi',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
