import 'package:material_ui/material_ui.dart';
import '../constants/app_colors.dart';
import '../../features/akun/presentation/pages/akun_page.dart';
import '../../features/akun/presentation/pages/pusat_bantuan_page.dart';
import '../../features/akun/presentation/pages/ubah_kata_sandi_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/lupa_kata_sandi_page.dart';
import '../../features/cuti/main/domain/entities/cuti_tab_type.dart';
import '../../features/cuti/main/presentation/pages/main_cuti_page.dart';
import '../../features/jadwal/presentation/pages/jadwal_page.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/notification/presentation/pages/notification_page.dart';
import '../../features/payroll/presentation/pages/payroll_denda_tunjangan_page.dart';
import '../../features/payroll/presentation/pages/payroll_detail_slip_page.dart';
import '../../features/payroll/presentation/pages/payroll_page.dart';
import '../../features/presensi/domain/entities/presensi_data.dart';
import '../../features/presensi/presentation/pages/presensi_scan_page.dart';
import '../../features/riwayat_absen/presentation/pages/riwayat_absen_page.dart';
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

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

      case AppRoutes.lupaKataSandi:
        return MaterialPageRoute(
          builder: (_) => const LupaKataSandiPage(),
          settings: settings,
        );

      case AppRoutes.notification:
        return MaterialPageRoute(
          builder: (_) => const NotificationPage(),
          settings: settings,
        );

      case AppRoutes.riwayatAbsen:
        return MaterialPageRoute(
          builder: (_) => const RiwayatAbsenPage(),
          settings: settings,
        );

      case AppRoutes.presensi:
        final initialType = settings.arguments is PresensiType
            ? settings.arguments as PresensiType
            : null;
        return MaterialPageRoute(
          builder: (_) => PresensiScanPage(initialType: initialType),
          settings: settings,
        );

      case AppRoutes.ajukanCuti:
        final initialTab = settings.arguments is CutiTabType
            ? settings.arguments as CutiTabType
            : CutiTabType.cutiTahunan;
        return MaterialPageRoute(
          builder: (_) => MainCutiPage(initialTab: initialTab),
          settings: settings,
        );

      case AppRoutes.jadwal:
        return MaterialPageRoute(
          builder: (_) => const JadwalPage(),
          settings: settings,
        );

      case AppRoutes.payroll:
        return MaterialPageRoute(
          builder: (_) => const PayrollPage(),
          settings: settings,
        );

      case AppRoutes.payrollDetail:
        return MaterialPageRoute(
          builder: (_) => const PayrollDetailSlipPage(),
          settings: settings,
        );

      case AppRoutes.payrollDendaTunjangan:
        return MaterialPageRoute(
          builder: (_) => const PayrollDendaTunjanganPage(),
          settings: settings,
        );

      case AppRoutes.akun:
        return MaterialPageRoute(
          builder: (_) => const AkunPage(),
          settings: settings,
        );

      case AppRoutes.ubahKataSandi:
        return MaterialPageRoute(
          builder: (_) => const UbahKataSandiPage(),
          settings: settings,
        );

      case AppRoutes.pusatBantuan:
        return MaterialPageRoute(
          builder: (_) => const PusatBantuanPage(),
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
