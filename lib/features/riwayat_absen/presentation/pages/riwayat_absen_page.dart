import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../injection_container.dart';
import '../../../cuti/main/domain/entities/cuti_tab_type.dart';
import '../../domain/entities/riwayat_absen_item.dart';
import '../bloc/riwayat_absen_bloc.dart';
import '../bloc/riwayat_absen_event.dart';
import '../bloc/riwayat_absen_state.dart';
import '../widgets/riwayat_absen_card_widget.dart';
import '../widgets/riwayat_filter_tabs_widget.dart';
import '../widgets/riwayat_koreksi_bottom_sheet.dart';
import '../widgets/riwayat_month_selector_widget.dart';
import '../widgets/riwayat_summary_stats_widget.dart';

class RiwayatAbsenPage extends StatelessWidget {
  const RiwayatAbsenPage({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<RiwayatAbsenBloc>();
      return const _RiwayatAbsenView();
    } catch (_) {
      return BlocProvider(
        create: (_) =>
            sl<RiwayatAbsenBloc>()..add(const LoadRiwayatAbsenEvent()),
        child: const _RiwayatAbsenView(),
      );
    }
  }
}

class _RiwayatAbsenView extends StatelessWidget {
  const _RiwayatAbsenView();

  void _openKoreksiSheet(BuildContext context, RiwayatAbsenItem item) {
    final bloc = context.read<RiwayatAbsenBloc>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => RiwayatKoreksiBottomSheet(
        item: item,
        onSubmit: (reason) {
          bloc.add(SubmitKoreksiAbsenEvent(itemId: item.id, reason: reason));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Top White App Bar Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x080F172A),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 22,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'Riwayat Absen',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Scrollable Body
          Expanded(
            child: BlocConsumer<RiwayatAbsenBloc, RiwayatAbsenState>(
              listener: (context, state) {
                if (state is RiwayatAbsenLoaded &&
                    state.feedbackMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.feedbackMessage!),
                      backgroundColor: const Color(0xFF15803D),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is RiwayatAbsenLoading ||
                    state is RiwayatAbsenInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                } else if (state is RiwayatAbsenError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            size: 48,
                            color: AppColors.error,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<RiwayatAbsenBloc>()
                                  .add(const LoadRiwayatAbsenEvent());
                            },
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is RiwayatAbsenLoaded) {
                  final data = state.data;
                  final filtered = state.filteredItems;
                  final visible = state.visibleItems;
                  final hasMore =
                      filtered.length > RiwayatAbsenLoaded.initialVisibleCount;

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Column(
                      children: [
                        // 1. Month Selector
                        RiwayatMonthSelectorWidget(
                          monthLabel: data.monthLabel,
                          onPreviousMonth: () {
                            context
                                .read<RiwayatAbsenBloc>()
                                .add(const ChangeRiwayatMonthEvent(-1));
                          },
                          onNextMonth: () {
                            context
                                .read<RiwayatAbsenBloc>()
                                .add(const ChangeRiwayatMonthEvent(1));
                          },
                        ),
                        const SizedBox(height: 12),

                        // 2. 4 Summary Stats Row
                        RiwayatSummaryStatsWidget(
                          hadirCount: data.hadirCount,
                          telatCount: data.telatCount,
                          cutiIzinCount: data.cutiIzinCount,
                          menungguCount: data.menungguCount,
                        ),
                        const SizedBox(height: 12),

                        // 3. Segmented Filter Tabs
                        RiwayatFilterTabsWidget(
                          selectedFilter: state.selectedFilter,
                          onFilterSelected: (filter) {
                            context
                                .read<RiwayatAbsenBloc>()
                                .add(SelectRiwayatFilterEvent(filter));
                          },
                        ),
                        const SizedBox(height: 14),

                        // 4. Attendance Log Cards
                        if (visible.isEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 36,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border:
                                  Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.history_toggle_off_rounded,
                                  size: 40,
                                  color: AppColors.textTertiary,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Belum ada data untuk filter ini',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          ...List.generate(visible.length, (index) {
                            final item = visible[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == visible.length - 1 ? 0 : 12,
                              ),
                              child: RiwayatAbsenCardWidget(
                                item: item,
                                onUploadTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.ajukanCuti,
                                    arguments: CutiTabType.izinSakit,
                                  );
                                },
                                onKoreksiTap: () =>
                                    _openKoreksiSheet(context, item),
                              ),
                            );
                          }),

                        // 5. Bottom Expand / Collapse Button
                        if (hasMore) ...[
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () {
                              context
                                  .read<RiwayatAbsenBloc>()
                                  .add(const ToggleShowAllRiwayatEvent());
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: double.infinity,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFF93C5FD)),
                              ),
                              child: Center(
                                child: Text(
                                  state.showAll
                                      ? 'Tampilkan Lebih Sedikit  ↑'
                                      : 'Tampilkan Semua di Bulan Ini (${filtered.length})  ↓',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1D5CE6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
