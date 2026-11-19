import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/home_attendance_card_widget.dart';
import '../widgets/home_error_widget.dart';
import '../widgets/home_menu_grid_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<HomeBloc>();
      return const HomeView();
    } catch (_) {
      return BlocProvider(
        create: (_) => sl<HomeBloc>()..add(const LoadHomeDashboardEvent()),
        child: const HomeView(),
      );
    }
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 96),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Today's Attendance Card (Kehadiran Hari Ini)
                    HomeAttendanceCardWidget(
                      attendance: dashboard.todayAttendance,
                      statistics: dashboard.statistics,
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
                    const SizedBox(height: 20),

                    // 2. Layanan Mandiri Personel (4 Modul Utama)
                    HomeMenuGridWidget(menus: dashboard.menus),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
