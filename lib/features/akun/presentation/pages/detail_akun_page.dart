import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/akun_profile.dart';
import '../bloc/akun_bloc.dart';
import '../bloc/akun_event.dart';
import '../bloc/akun_state.dart';

class DetailAkunPage extends StatelessWidget {
  final AkunProfile? profile;

  const DetailAkunPage({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile != null) {
      return _DetailAkunView(profile: profile!);
    }

    return BlocProvider(
      create: (_) => sl<AkunBloc>()..add(const LoadAkunProfileEvent()),
      child: BlocBuilder<AkunBloc, AkunState>(
        builder: (context, state) {
          if (state is AkunLoaded) {
            return _DetailAkunView(profile: state.profile);
          }
          if (state is AkunError) {
            return Scaffold(
              backgroundColor: const Color(0xFFF8FAFC),
              body: Column(
                children: [
                  const _DetailAkunHeader(),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Scaffold(
            backgroundColor: Color(0xFFF8FAFC),
            body: Column(
              children: [
                _DetailAkunHeader(),
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DetailAkunHeader extends StatelessWidget {
  const _DetailAkunHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.of(context).maybePop(),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
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
              ),
              const Expanded(
                child: Text(
                  'Data Kepegawaian & Payroll',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.verified_user_outlined,
                    size: 20,
                    color: Color(0xFF1D5CE6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailAkunView extends StatelessWidget {
  final AkunProfile profile;

  const _DetailAkunView({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          const _DetailAkunHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                children: [
                  _buildHeroCard(),
                  const SizedBox(height: 16),

                  // 1. IDENTITAS PRIBADI & KONTAK
                  _buildSectionCard(
                    icon: Icons.badge_outlined,
                    iconBgColor: const Color(0xFFEFF6FF),
                    iconColor: const Color(0xFF1D5CE6),
                    title: 'IDENTITAS PRIBADI & KONTAK',
                    rows: [
                      _DetailRowItem(
                        label: 'NIK (KTP)',
                        value: profile.nik,
                        isMonospace: true,
                      ),
                      _DetailRowItem(
                        label: 'Tempat, Tgl Lahir',
                        value: profile.birthPlaceDate,
                      ),
                      _DetailRowItem(
                        label: 'Email Resmi',
                        value: profile.email,
                      ),
                      _DetailRowItem(
                        label: 'No. WhatsApp',
                        value: profile.whatsappNumber,
                      ),
                      _DetailRowItem(
                        label: 'Domisili',
                        value: profile.domicile,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 2. PENEMPATAN & JADWAL SHIFT
                  _buildSectionCard(
                    icon: Icons.apartment_rounded,
                    iconBgColor: const Color(0xFFEEF2FF),
                    iconColor: const Color(0xFF4F46E5),
                    title: 'PENEMPATAN & JADWAL SHIFT',
                    rows: [
                      _DetailRowItem(
                        label: 'Unit Dapur SPPG',
                        value: profile.locationBadge,
                      ),
                      _DetailRowItem(
                        label: 'Divisi Operasional',
                        value: profile.operationalDivision,
                      ),
                      _DetailRowItem(
                        label: 'Tanggal Bergabung',
                        value: profile.joinDate,
                      ),
                      _DetailRowItem(
                        label: 'Jadwal Shift Utama',
                        valueWidget: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            profile.mainShiftSchedule,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1D5CE6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 3. REKENING PAYROLL & JAMINAN
                  _buildSectionCard(
                    icon: Icons.credit_card_rounded,
                    iconBgColor: const Color(0xFFECFDF5),
                    iconColor: const Color(0xFF16A34A),
                    title: 'REKENING PAYROLL & JAMINAN',
                    headerTrailing: profile.isPayrollVerified
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFECFDF5),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: const Color(0xFFBBF7D0),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_rounded,
                                  size: 13,
                                  color: Color(0xFF15803D),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Terverifikasi',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF15803D),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : null,
                    rows: [
                      _DetailRowItem(
                        label: 'Bank Penyalur',
                        value: profile.bankName,
                      ),
                      _DetailRowItem(
                        label: 'Nomor Rekening',
                        value: profile.accountNumber,
                        isMonospace: true,
                      ),
                      _DetailRowItem(
                        label: 'Nama Pemilik',
                        value: profile.accountHolderName,
                      ),
                      _DetailRowItem(
                        label: 'BPJS Kesehatan & TK',
                        valueWidget: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: Color(0xFF16A34A),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                profile.bpjsStatus,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF15803D),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 4. Info Notice Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F7FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFDCEAFE)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 18,
                            color: Color(0xFF1D5CE6),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Perubahan data NIK, nomor rekening gaji, atau jadwal shift utama hanya dapat dilakukan melalui Admin Unit SPPG / HR Pusat.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E40AF),
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1F65ED), Color(0xFF1A56E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x331D5CE6),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Positioned(
              right: -28,
              bottom: -28,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: profile.avatarUrl != null &&
                                      profile.avatarUrl!.isNotEmpty
                                  ? Image.network(
                                      profile.avatarUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, _, _) =>
                                          _buildAvatarFallback(),
                                    )
                                  : _buildAvatarFallback(),
                            ),
                          ),
                          if (profile.isOnline)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.16),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.25),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4ADE80),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    profile.employmentStatus,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              profile.fullName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              profile.roleLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.90),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Container(
                      height: 1,
                      color: Colors.white.withValues(alpha: 0.18),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID PERSONEL',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6,
                                color: Colors.white.withValues(alpha: 0.78),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profile.personnelId,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MASA KERJA',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6,
                                color: Colors.white.withValues(alpha: 0.78),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profile.workTenure,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarFallback() {
    return Container(
      color: const Color(0xFF52525B),
      alignment: Alignment.bottomCenter,
      child: const Icon(
        Icons.person_rounded,
        size: 46,
        color: Color(0xFFD4D4D8),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required List<_DetailRowItem> rows,
    Widget? headerTrailing,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x060F172A),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(icon, size: 17, color: iconColor),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF475569),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              ?headerTrailing,
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 4),
          for (int i = 0; i < rows.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    rows[i].label,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: rows[i].valueWidget ??
                          Text(
                            rows[i].value ?? '-',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                              fontFeatures: rows[i].isMonospace
                                  ? const [FontFeature.tabularFigures()]
                                  : null,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            if (i < rows.length - 1)
              const Divider(height: 1, thickness: 1, color: Color(0xFFF8FAFC)),
          ],
        ],
      ),
    );
  }
}

class _DetailRowItem {
  final String label;
  final String? value;
  final Widget? valueWidget;
  final bool isMonospace;

  const _DetailRowItem({
    required this.label,
    this.value,
    this.valueWidget,
    this.isMonospace = false,
  });
}
