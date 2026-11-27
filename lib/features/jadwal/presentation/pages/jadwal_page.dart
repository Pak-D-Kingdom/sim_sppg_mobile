import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';
import '../../../../injection_container.dart';
import '../bloc/jadwal_bloc.dart';
import '../bloc/jadwal_event.dart';
import '../bloc/jadwal_state.dart';
import '../widgets/jadwal_calendar_widget.dart';
import '../widgets/jadwal_detail_card_widget.dart';
import '../widgets/jadwal_header_widget.dart';
import '../widgets/jadwal_summary_cards_widget.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<JadwalBloc>();
      return const _JadwalPageView();
    } catch (_) {
      return BlocProvider(
        create: (_) => sl<JadwalBloc>()..add(const LoadJadwalEvent()),
        child: const _JadwalPageView(),
      );
    }
  }
}

class _JadwalPageView extends StatelessWidget {
  const _JadwalPageView();

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<JadwalBloc, JadwalState>(
          builder: (context, state) {
            if (state is JadwalLoading || state is JadwalInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is JadwalError) {
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
                      const SizedBox(height: 16),
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
                          context.read<JadwalBloc>().add(const LoadJadwalEvent());
                        },
                        child: Text(context.l10n.tryAgain),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is JadwalLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed / Sticky Top Bar (Tidak ikut ter-scroll)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: JadwalHeaderWidget(
                      title: context.l10n.scheduleAndHolidays,
                      location: state.data.location,
                      showBackButton: canPop,
                    ),
                  ),

                  // Konten yang dapat di-scroll
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 2. Summary Metric Cards (Hari Kerja, Libur/Off, Kuota Cuti)
                          JadwalSummaryCardsWidget(
                            summary: state.data.summary,
                          ),
                          const SizedBox(height: 16),

                          // 3. Calendar Card with Legend
                          JadwalCalendarWidget(
                            currentMonthYear: state.data.currentMonthYear,
                            currentMonth: state.data.currentMonth,
                            currentYear: state.data.currentYear,
                            days: state.data.days,
                            selectedDate: state.selectedDate,
                            isLoading: state.isCalendarLoading,
                            onSelectDate: (date) {
                              context
                                  .read<JadwalBloc>()
                                  .add(SelectJadwalDateEvent(date));
                            },
                            onPreviousMonth: () {
                              context
                                  .read<JadwalBloc>()
                                  .add(const ChangeMonthEvent(-1));
                            },
                            onNextMonth: () {
                              context
                                  .read<JadwalBloc>()
                                  .add(const ChangeMonthEvent(1));
                            },
                          ),
                          const SizedBox(height: 16),

                          // 4. Detail Card for the Selected Date
                          JadwalDetailCardWidget(
                            day: state.selectedDay,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
