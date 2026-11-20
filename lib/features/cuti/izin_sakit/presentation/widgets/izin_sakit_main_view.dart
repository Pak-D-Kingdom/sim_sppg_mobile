import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sim_sppg_mobile/core/constants/app_colors.dart';
import 'package:sim_sppg_mobile/injection_container.dart';
import '../bloc/izin_sakit_bloc.dart';
import '../bloc/izin_sakit_event.dart';
import '../bloc/izin_sakit_state.dart';
import '../../domain/entities/izin_sakit_entity.dart';
import 'izin_sakit_tahap1_view.dart';
import 'izin_sakit_tahap2_view.dart';

class IzinSakitMainView extends StatelessWidget {
  const IzinSakitMainView({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<IzinSakitBloc>();
      return const _IzinSakitContent();
    } catch (_) {
      return BlocProvider(
        create: (_) => sl<IzinSakitBloc>()..add(const LoadIzinSakitInitialEvent()),
        child: const _IzinSakitContent(),
      );
    }
  }
}

class _IzinSakitContent extends StatelessWidget {
  const _IzinSakitContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IzinSakitBloc, IzinSakitState>(
      listener: (context, state) {
        if (state is IzinSakitLoaded) {
          if (state.successMessage != null) {
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
        if (state is IzinSakitLoading || state is IzinSakitInitial) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        } else if (state is IzinSakitError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Icon(Icons.error_outline_rounded,
                      size: 40, color: AppColors.error),
                  const SizedBox(height: 12),
                  Text(state.message,
                      style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<IzinSakitBloc>()
                          .add(const LoadIzinSakitInitialEvent());
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          );
        } else if (state is IzinSakitLoaded) {
          // Automatic stage rendering: Tahap 1 (Gambar 1) vs Tahap 2 (Gambar 2)
          if (state.data.tahap == IzinSakitTahap.tahap1Form) {
            return IzinSakitTahap1View(state: state);
          } else {
            return IzinSakitTahap2View(state: state);
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
