import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../injection_container.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<AuthBloc>();
      return const _LoginView();
    } catch (_) {
      return BlocProvider(
        create: (_) => sl<AuthBloc>(),
        child: const _LoginView(),
      );
    }
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _identifierController =
      TextEditingController(text: 'SPPG-RMG-014');
  final TextEditingController _passwordController =
      TextEditingController(text: 'sppg2026123');

  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmitLogin() {
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
          SubmitLoginEvent(
            identifier: _identifierController.text,
            password: _passwordController.text,
            rememberMe: _rememberMe,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.main,
                (route) => false,
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Stack(
                        children: [
                          // 1. Curved Vibrant Royal Blue Background Header
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: topPadding + 292,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(32),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF1F65ED),
                                      Color(0xFF1A56E0),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    // Top-right soft decorative circle
                                    Positioned(
                                      top: -40,
                                      right: -45,
                                      child: Container(
                                        width: 190,
                                        height: 190,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white
                                              .withValues(alpha: 0.08),
                                        ),
                                      ),
                                    ),
                                    // Bottom-left soft decorative circle
                                    Positioned(
                                      bottom: -35,
                                      left: -55,
                                      child: Container(
                                        width: 185,
                                        height: 185,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white
                                              .withValues(alpha: 0.07),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // 2. Foreground Content
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              18,
                              topPadding + 28,
                              18,
                              bottomPadding + 18,
                            ),
                            child: Column(
                              children: [
                                // Brand Logo Box
                                Container(
                                  width: 66,
                                  height: 66,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x240F172A),
                                        blurRadius: 16,
                                        offset: Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.health_and_safety_outlined,
                                      size: 32,
                                      color: Color(0xFF1D5CE6),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),

                                // Agency Pill
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.30),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Text(
                                    'BADAN GIZI NASIONAL',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // App Title
                                const Text(
                                  'SIM-SPPG',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // App Subtitle
                                Text(
                                  l10n.appFullSubtitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withValues(alpha: 0.88),
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 26),

                                // 3. Floating Login Card
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 22, 20, 22),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: const Color(0xFFEEF2F6),
                                      width: 1,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x140F172A),
                                        blurRadius: 20,
                                        offset: Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.loginToAccount,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.onSurface,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        l10n.loginSubtitle,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 18),

                                      // ID Personel / Email
                                      Text(
                                        l10n.personnelIdOrEmail,
                                        style: const TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      TextField(
                                        controller: _identifierController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        style: const TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.onSurface,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'SPPG-RMG-014',
                                          hintStyle: const TextStyle(
                                            fontSize: 13.5,
                                            color: AppColors.textTertiary,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.person_outline_rounded,
                                            size: 20,
                                            color: Color(0xFF1D5CE6),
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFFF8FAFC),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 14,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFCBD5E1),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFCBD5E1),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF1D5CE6),
                                              width: 1.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 14),

                                      // Kata Sandi
                                      Text(
                                        l10n.password,
                                        style: const TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      TextField(
                                        controller: _passwordController,
                                        obscureText: _obscurePassword,
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (_) => _onSubmitLogin(),
                                        style: const TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.onSurface,
                                          letterSpacing: 1.2,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: l10n.enterPassword,
                                          hintStyle: const TextStyle(
                                            fontSize: 13.5,
                                            color: AppColors.textTertiary,
                                            letterSpacing: 0,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.lock_outline_rounded,
                                            size: 20,
                                            color: AppColors.textSecondary,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              size: 20,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFFF8FAFC),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 14,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFCBD5E1),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFCBD5E1),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF1D5CE6),
                                              width: 1.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 14),

                                      // Remember Me & Forgot Password Row
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                _rememberMe = !_rememberMe;
                                              });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 2,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  AnimatedContainer(
                                                    duration: const Duration(
                                                      milliseconds: 150,
                                                    ),
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                      color: _rememberMe
                                                          ? const Color(
                                                              0xFF1D5CE6,
                                                            )
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5,
                                                      ),
                                                      border: Border.all(
                                                        color: _rememberMe
                                                            ? const Color(
                                                                0xFF1D5CE6,
                                                              )
                                                            : const Color(
                                                                0xFFCBD5E1,
                                                              ),
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                    child: _rememberMe
                                                        ? const Icon(
                                                            Icons.check_rounded,
                                                            size: 13,
                                                            color: Colors.white,
                                                          )
                                                        : null,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    l10n.rememberMe,
                                                    style: const TextStyle(
                                                      fontSize: 12.5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFF475569),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.lupaKataSandi,
                                              );
                                            },
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 2,
                                                vertical: 2,
                                              ),
                                              child: Text(
                                                l10n.forgotPassword,
                                                style: const TextStyle(
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF1D5CE6),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 18),

                                      // Primary Login Button
                                      Container(
                                        width: double.infinity,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x331D5CE6),
                                              blurRadius: 12,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          onPressed:
                                              isLoading ? null : _onSubmitLogin,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF1D5CE6),
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                          child: isLoading
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.white,
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  l10n.loginButtonArrow,
                                                  style: const TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // 4. Info Notice Box (No Register)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F7FF),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: const Color(0xFFDCEAFE),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE0ECFF),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.privacy_tip_outlined,
                                            size: 16,
                                            color: Color(0xFF1D5CE6),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          l10n.accountManagedNotice,
                                          style: const TextStyle(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF475569),
                                            height: 1.45,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),
                                const SizedBox(height: 24),

                                // 5. Version Footer
                                const Text(
                                  'SIM-SPPG Mobile v2.4.0 • Badan Gizi Nasional',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
