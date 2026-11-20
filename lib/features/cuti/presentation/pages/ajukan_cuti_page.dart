import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../bloc/cuti_bloc.dart';
import '../bloc/cuti_event.dart';
import '../bloc/cuti_state.dart';
import '../widgets/cuti_date_picker_card_widget.dart';
import '../widgets/cuti_footer_button_widget.dart';
import '../widgets/cuti_form_card_widget.dart';
import '../widgets/cuti_header_widget.dart';
import '../widgets/cuti_quota_card_widget.dart';
import '../widgets/cuti_type_tab_wrapper_widget.dart';

class AjukanCutiPage extends StatelessWidget {
  const AjukanCutiPage({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<CutiBloc>();
      return const _AjukanCutiPageView();
    } catch (_) {
      return BlocProvider(
        create: (_) => sl<CutiBloc>()..add(const LoadCutiInitialEvent()),
        child: const _AjukanCutiPageView(),
      );
    }
  }
}

class _AjukanCutiPageView extends StatelessWidget {
  const _AjukanCutiPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<CutiBloc, CutiState>(
          listener: (context, state) {
            if (state is CutiLoaded) {
              if (state.successMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.successMessage!),
                    backgroundColor: const Color(0xFF16A34A),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.maybePop(context);
              } else if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is CutiLoading || state is CutiInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is CutiError) {
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
                          context
                              .read<CutiBloc>()
                              .add(const LoadCutiInitialEvent());
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is CutiLoaded) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header (Circular Back Button & Title)
                    const CutiHeaderWidget(),
                    const SizedBox(height: 16),

                    // 2. Wrapper Tabs ('Cuti Tahunan', 'Izin Sakit', 'Izin Darurat')
                    CutiTypeTabWrapperWidget(
                      selectedType: state.selectedType,
                      onTypeChanged: (type) {
                        context
                            .read<CutiBloc>()
                            .add(ChangeCutiTypeEvent(type));
                      },
                    ),
                    const SizedBox(height: 16),

                    // 3. Quota & Policy Notice Card
                    CutiQuotaCardWidget(
                      quota: state.quota,
                      cutiType: state.selectedType,
                    ),
                    const SizedBox(height: 16),

                    // 4. Pilih Tanggal Pengajuan Card
                    CutiDatePickerCardWidget(
                      startDate: state.startDate,
                      endDate: state.endDate,
                      durationDays: state.durationDays,
                      remainingSaldo: state.remainingAfter,
                      cutiType: state.selectedType,
                      onStartDateChanged: (date) {
                        context
                            .read<CutiBloc>()
                            .add(UpdateCutiDatesEvent(startDate: date));
                      },
                      onEndDateChanged: (date) {
                        context
                            .read<CutiBloc>()
                            .add(UpdateCutiDatesEvent(endDate: date));
                      },
                    ),
                    const SizedBox(height: 16),

                    // 5. Alasan / Keterangan & Lampirkan Bukti Card
                    CutiFormCardWidget(
                      initialReason: state.reason,
                      attachmentName: state.attachmentName,
                      cutiType: state.selectedType,
                      onReasonChanged: (reason) {
                        context
                            .read<CutiBloc>()
                            .add(UpdateCutiReasonEvent(reason));
                      },
                      onAttachmentChanged: (attachment) {
                        context
                            .read<CutiBloc>()
                            .add(UpdateCutiAttachmentEvent(attachment));
                      },
                    ),
                    const SizedBox(height: 20),

                    // 6. Coordinator Info & Submit Button
                    CutiFooterButtonWidget(
                      isSubmitting: state.isSubmitting,
                      onSubmit: () {
                        context
                            .read<CutiBloc>()
                            .add(const SubmitCutiFormEvent());
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
