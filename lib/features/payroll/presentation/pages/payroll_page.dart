import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';
import '../../../../injection_container.dart';
import '../bloc/payroll_bloc.dart';
import '../bloc/payroll_event.dart';
import '../bloc/payroll_state.dart';
import '../widgets/payroll_card_item_widget.dart';
import '../widgets/payroll_filter_year_widget.dart';
import '../widgets/payroll_header_widget.dart';

class PayrollPage extends StatelessWidget {
  const PayrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<PayrollBloc>();
      return const _PayrollPageView();
    } catch (_) {
      return BlocProvider(
        create: (_) => sl<PayrollBloc>()..add(const LoadPayrollEvent()),
        child: const _PayrollPageView(),
      );
    }
  }
}

class _PayrollPageView extends StatelessWidget {
  const _PayrollPageView();

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<PayrollBloc, PayrollState>(
          builder: (context, state) {
            if (state is PayrollLoading || state is PayrollInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is PayrollError) {
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
                          context.read<PayrollBloc>().add(const LoadPayrollEvent());
                        },
                        child: Text(context.l10n.tryAgain),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is PayrollLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed Top Bar (Sticky, tidak ter-scroll)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: PayrollHeaderWidget(
                      title: context.l10n.payrollTitle,
                      subtitle: context.l10n.payrollHeaderSubtitle,
                      showBackButton: canPop,
                    ),
                  ),

                  // Filter Tahun & Title Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: PayrollFilterYearWidget(
                      selectedYear: state.data.selectedYear,
                      availableYears: state.data.availableYears,
                      onYearSelected: (year) {
                        context
                            .read<PayrollBloc>()
                            .add(ChangePayrollYearEvent(year));
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Scrollable Payroll List
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                      itemCount: state.data.items.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = state.data.items[index];
                        final isExpanded = state.isExpanded(item.id);

                        return PayrollCardItemWidget(
                          item: item,
                          isExpanded: isExpanded,
                          onToggle: () {
                            context
                                .read<PayrollBloc>()
                                .add(TogglePayrollItemExpandEvent(item.id));
                          },
                        );
                      },
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
