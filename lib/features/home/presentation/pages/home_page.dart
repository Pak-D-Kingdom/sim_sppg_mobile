import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/home_attendance_card_widget.dart';
import '../widgets/home_bottom_nav_widget.dart';
import '../widgets/home_error_widget.dart';
import '../widgets/home_header_widget.dart';
import '../widgets/home_menu_grid_widget.dart';
import '../widgets/home_operational_alert_widget.dart';
import '../widgets/home_quality_banner_widget.dart';
import '../widgets/home_stats_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const LoadHomeDashboardEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (state is HomeError) {
            return HomeErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<HomeBloc>().add(const LoadHomeDashboardEvent());
              },
            );
          } else if (state is HomeLoaded) {
            final dashboard = state.dashboard;

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                context
                    .read<HomeBloc>()
                    .add(const RefreshHomeDashboardEvent());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Top AppBar & User Profile Card
                    HomeHeaderWidget(
                      appTitle: dashboard.appTitle,
                      appVersion: dashboard.appVersion,
                      agencyName: dashboard.agencyName,
                      userName: dashboard.userName,
                      userNik: dashboard.userNik,
                      userRole: dashboard.userRole,
                      employmentBadge: dashboard.employmentBadge,
                      locationBadge: dashboard.locationBadge,
                      unreadNotifications: dashboard.unreadNotifications,
                      onNotificationTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${dashboard.unreadNotifications} notifikasi operasional baru',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // 2. Operational Warning Banner (Peringatan Operasional)
                    HomeOperationalAlertWidget(
                      alert: dashboard.operationalAlert,
                    ),
                    const SizedBox(height: 16),

                    // 3. Today's Attendance Card (Kehadiran Hari Ini)
                    HomeAttendanceCardWidget(
                      attendance: dashboard.todayAttendance,
                      onClockOutTap: () {
                        context.read<HomeBloc>().add(
                              const ClockOutAttendanceEvent(
                                clockOutTime: '13:02',
                              ),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Clock-Out berhasil tercatat pada 13:02 WIB',
                            ),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 22),

                    // 4. Layanan Mandiri Personel (6 Modul Utama)
                    HomeMenuGridWidget(menus: dashboard.menus),
                    const SizedBox(height: 22),

                    // 5. Ringkasan Bulan Ini (November 2026)
                    HomeStatsSection(
                      statistics: dashboard.statistics,
                      periodLabel: dashboard.summaryPeriod,
                    ),
                    const SizedBox(height: 18),

                    // 6. Standar Mutu SPPG Quality Banner
                    HomeQualityBannerWidget(banner: dashboard.qualityBanner),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: HomeBottomNavWidget(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          if (index != 0) {
            final labels = ['Beranda', 'Presensi', 'Jadwal', 'Payroll', 'Akun'];
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Navigasi ke modul ${labels[index]}'),
                duration: const Duration(milliseconds: 800),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
      ),
    );
  }
}
