import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../home/presentation/bloc/home_event.dart';
import '../../../main/presentation/widgets/main_bottom_nav_widget.dart';
import '../../domain/entities/presensi_data.dart';
import '../bloc/presensi_bloc.dart';
import '../bloc/presensi_event.dart';
import '../bloc/presensi_state.dart';
import '../widgets/presensi_camera_viewfinder_widget.dart';
import '../widgets/presensi_clock_out_summary_widget.dart';
import '../widgets/presensi_location_card_widget.dart';
import '../widgets/presensi_time_info_widget.dart';

class PresensiScanPage extends StatelessWidget {
  final PresensiType? initialType;

  const PresensiScanPage({
    super.key,
    this.initialType,
  });

  @override
  Widget build(BuildContext context) {
    try {
      context.read<PresensiBloc>();
      return _PresensiScanPageView(initialType: initialType);
    } catch (_) {
      return BlocProvider(
        create: (_) => sl<PresensiBloc>()
          ..add(LoadPresensiStatusEvent(requestedType: initialType)),
        child: _PresensiScanPageView(initialType: initialType),
      );
    }
  }
}

class _PresensiScanPageView extends StatefulWidget {
  final PresensiType? initialType;

  const _PresensiScanPageView({this.initialType});

  @override
  State<_PresensiScanPageView> createState() => _PresensiScanPageViewState();
}

class _PresensiScanPageViewState extends State<_PresensiScanPageView> {
  @override
  void initState() {
    super.initState();
    if (widget.initialType != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<PresensiBloc>().add(
                TogglePresensiTypeEvent(widget.initialType!),
              );
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant _PresensiScanPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialType != null &&
        widget.initialType != oldWidget.initialType) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<PresensiBloc>().add(
                TogglePresensiTypeEvent(widget.initialType!),
              );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: BlocConsumer<PresensiBloc, PresensiState>(
          listener: (context, state) {
            if (state is PresensiLoaded) {
              if (state.successMessage != null) {
                // Update state di HomeBloc jika tersedia
                try {
                  final now = DateTime.now();
                  final timeStr =
                      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
                  context
                      .read<HomeBloc>()
                      .add(ClockOutAttendanceEvent(clockOutTime: timeStr));
                } catch (_) {}

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.successMessage!),
                    backgroundColor: const Color(0xFF16A34A),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
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
            if (state is PresensiLoading || state is PresensiInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is PresensiError) {
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
                          context.read<PresensiBloc>().add(
                                LoadPresensiStatusEvent(
                                  requestedType: widget.initialType,
                                ),
                              );
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is PresensiLoaded) {
              final data = state.data;
              final isClockIn = data.type == PresensiType.clockIn;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header (Sticky Top Bar)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Row(
                      children: [
                        if (canPop) ...[
                          InkWell(
                            onTap: () => Navigator.of(context).maybePop(),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: const Color(0xFFE2E8F0)),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 16,
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isClockIn
                                    ? 'Presensi Kehadiran'
                                    : 'Presensi Pulang',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.onSurface,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'SPPG Rawamangun 01 • Shift Pagi (05:00 - 13:00 WIB)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. Scrollable Body Content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      child: Column(
                        children: [
                          // Jika mode Clock-Out, tampilkan Ringkasan Clock-In & Durasi Kerja (Gambar 2)
                          if (!isClockIn) ...[
                            PresensiClockOutSummaryWidget(
                              clockInTime: data.clockInTime,
                              clockInStatus: data.clockInStatus,
                              workDuration: data.workDuration,
                            ),
                            const SizedBox(height: 12),
                          ],

                          // Lokasi Dapur Terverifikasi Box (Gambar 1 & Gambar 2)
                          PresensiLocationCardWidget(
                            title: data.locationTitle,
                            distance: data.locationDistance,
                            isInRadius: data.isInRadius,
                          ),
                          const SizedBox(height: 14),

                          // Kamera & Viewfinder Biometrik (Gambar 1 & Gambar 2)
                          PresensiCameraViewfinderWidget(
                            isFaceDetected: data.isFaceDetected,
                            isLivenessOk: data.isLivenessOk,
                            onPhotoCaptured: () {
                              context.read<PresensiBloc>().add(
                                    CaptureFacePhotoEvent(
                                      'selfie_${DateTime.now().millisecondsSinceEpoch}.jpg',
                                    ),
                                  );
                            },
                          ),
                          const SizedBox(height: 14),

                          // Box Info Batas Waktu / Jadwal Pulang
                          PresensiTimeInfoWidget(
                            type: data.type,
                            text: data.deadlineText,
                            badge: data.remainingTimeBadge,
                          ),
                          const SizedBox(height: 16),

                          // Tombol Konfirmasi Presensi
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: state.isSubmitting
                                  ? null
                                  : () {
                                      context
                                          .read<PresensiBloc>()
                                          .add(const SubmitPresensiEvent());
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF9FC5E8),
                                foregroundColor: const Color(0xFF0F172A),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: state.isSubmitting
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0xFF0F172A),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        isClockIn
                                            ? const FaceScanIcon(
                                                size: 20,
                                                color: Color(0xFF0F172A),
                                                strokeWidth: 2.2,
                                              )
                                            : const Icon(
                                                Icons.logout_rounded,
                                                size: 20,
                                              ),
                                        const SizedBox(width: 8),
                                        Text(
                                          isClockIn
                                              ? 'Konfirmasi Clock-In (Masuk)'
                                              : 'Konfirmasi Clock-Out (Pulang)',
                                          style: const TextStyle(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: -0.2,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
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
