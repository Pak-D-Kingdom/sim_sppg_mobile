import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../injection_container.dart';
import '../bloc/akun_bloc.dart';
import '../bloc/akun_event.dart';
import '../bloc/akun_state.dart';
import '../widgets/akun_hero_card_widget.dart';
import '../widgets/akun_kepegawaian_card_widget.dart';
import '../widgets/akun_settings_card_widget.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<AkunBloc>();
      return const _AkunPageView();
    } catch (_) {
      return BlocProvider(
        create: (_) => sl<AkunBloc>()..add(const LoadAkunProfileEvent()),
        child: const _AkunPageView(),
      );
    }
  }
}

class _AkunPageView extends StatelessWidget {
  const _AkunPageView();

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Text(
          'Keluar dari Akun?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.onSurface,
          ),
        ),
        content: const Text(
          'Anda harus masuk kembali menggunakan kredensial personel SPPG untuk mengakses aplikasi.',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(
              'Batal',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              minimumSize: const Size(0, 40),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Keluar',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Top White Header
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
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Row(
                  children: [
                    if (canPop) ...[
                      InkWell(
                        onTap: () => Navigator.of(context).maybePop(),
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE2E8F0)),
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
                    ],
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profil',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.onSurface,
                              letterSpacing: -0.4,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Informasi kepegawaian & pengaturan akun',
                            style: TextStyle(
                              fontSize: 12.5,
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
            ),
          ),

          // Scrollable Body
          Expanded(
            child: BlocBuilder<AkunBloc, AkunState>(
              builder: (context, state) {
                if (state is AkunLoading || state is AkunInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                } else if (state is AkunError) {
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
                                  .read<AkunBloc>()
                                  .add(const LoadAkunProfileEvent());
                            },
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is AkunLoaded) {
                  final profile = state.profile;

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
                    child: Column(
                      children: [
                        // 1. Vibrant Royal Blue Profile Hero Card
                        AkunHeroCardWidget(profile: profile),
                        const SizedBox(height: 14),

                        // 2. Data Kepegawaian & Payroll Card
                        AkunKepegawaianCardWidget(profile: profile),
                        const SizedBox(height: 14),

                        // 3. Account Settings & Help Menu Card
                        AkunSettingsCardWidget(
                          onChangePasswordTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.ubahKataSandi,
                            );
                          },
                          onHelpCenterTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.pusatBantuan,
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        // 4. Logout Button
                        Material(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(14),
                          child: InkWell(
                            onTap: () => _showLogoutDialog(context),
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFFECACA),
                                  width: 1,
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout_rounded,
                                    size: 18,
                                    color: Color(0xFFDC2626),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Keluar dari Akun',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFDC2626),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // 5. Version Footer
                        Text(
                          profile.appVersionText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                          ),
                        ),
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
