import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../home/presentation/bloc/home_event.dart';
import '../../../home/presentation/bloc/home_state.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../widgets/main_bottom_nav_widget.dart';
import '../widgets/main_top_bar_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const LoadHomeDashboardEvent()),
      child: const _MainPageContent(),
    );
  }
}

class _MainPageContent extends StatefulWidget {
  const _MainPageContent();

  @override
  State<_MainPageContent> createState() => _MainPageContentState();
}

class _MainPageContentState extends State<_MainPageContent> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    _PlaceholderTabScreen(
      title: 'Jadwal & Shift',
      description: 'Manajemen jadwal shift dan rotasi tim dapur sentral.',
      icon: Icons.calendar_today_outlined,
    ),
    _PlaceholderTabScreen(
      title: 'Presensi Scan (QR & GPS)',
      description: 'Fitur presensi scan QR dapur dan verifikasi biometrik.',
      icon: Icons.qr_code_scanner_rounded,
    ),
    _PlaceholderTabScreen(
      title: 'Slip Payroll',
      description: 'Rekapitulasi gaji bulanan dan rincian kehadiran.',
      icon: Icons.receipt_long_outlined,
    ),
    _PlaceholderTabScreen(
      title: 'Profil & Akun',
      description: 'Pengaturan akun staf, sertifikasi gizi, dan preferensi.',
      icon: Icons.person_outline_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Dynamic Top Bar matching the design
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                return MainTopBarWidget(
                  userName: state.dashboard.userName,
                  locationBadge: 'SPPG Rawamangun 01',
                  unreadNotifications: state.dashboard.unreadNotifications,
                );
              }
              return const MainTopBarWidget();
            },
          ),

          // Active Screen
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomNavWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _PlaceholderTabScreen extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _PlaceholderTabScreen({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 36,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
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
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondarySoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Tahap Pengembangan Modul',
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
    );
  }
}
