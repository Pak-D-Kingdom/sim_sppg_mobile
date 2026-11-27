import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/payroll_item.dart';

class PayrollCardItemWidget extends StatelessWidget {
  final PayrollItem item;
  final bool isExpanded;
  final VoidCallback onToggle;

  const PayrollCardItemWidget({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Header Card (Selalu tampak)
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isExpanded
                    ? const Color(0xFF2563EB)
                    : const Color(0xFFE2E8F0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Info Bulan & Ringkasan Kehadiran
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            context.localizeDynamic(item.monthYear),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.onSurface,
                              letterSpacing: -0.2,
                            ),
                          ),
                          if (item.isLatest) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(color: const Color(0xFFBFDBFE)),
                              ),
                              child: Text(
                                context.l10n.latestBadge,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.localizeDynamic(item.summaryText),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Nominal & Status Terbayar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.amount,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_rounded,
                            size: 11,
                            color: Color(0xFF16A34A),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            context.localizeDynamic(item.status),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),

                // Tombol Lingkaran Expand / Collapse
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isExpanded ? Colors.white : const Color(0xFFF8FAFC),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isExpanded
                          ? const Color(0xFF2563EB)
                          : const Color(0xFFE2E8F0),
                      width: isExpanded ? 1.5 : 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: isExpanded
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // 2. Dropdown / Accordion Body (Muncul saat isExpanded = true)
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: _buildExpandedContent(context),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 260),
        ),
      ],
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          // Row 3 Metric Cards
          Row(
            children: [
              // Kehadiran
              Expanded(
                child: _buildMetricCard(
                  title: l10n.attendanceUpper,
                  value: context.localizeDynamic(item.detail.kehadiranValue),
                  valueColor: AppColors.onSurface,
                  subtitle:
                      context.localizeDynamic(item.detail.kehadiranSubtitle),
                  subtitleColor: const Color(0xFFEA580C),
                ),
              ),
              const SizedBox(width: 8),

              // Cuti / Izin
              Expanded(
                child: _buildMetricCard(
                  title: l10n.leaveSlashUpper,
                  value: context.localizeDynamic(item.detail.cutiValue),
                  valueColor: const Color(0xFF7C3AED),
                  subtitle: context.localizeDynamic(item.detail.cutiSubtitle),
                  subtitleColor: const Color(0xFF16A34A),
                ),
              ),
              const SizedBox(width: 8),

              // Denda Telat
              Expanded(
                child: _buildMetricCard(
                  title: l10n.latePenaltyUpper,
                  value: item.detail.dendaValue,
                  valueColor: const Color(0xFFDC2626),
                  subtitle: context.localizeDynamic(item.detail.dendaSubtitle),
                  subtitleColor: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Tombol Putih "Lihat Rincian Slip →"
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.payrollDetail);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0F172A),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.viewSlipDetails,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward_rounded, size: 15),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Banner Rincian Denda & Tunjangan
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.payrollDendaTunjangan);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Icon Persen
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF6FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.percent_rounded,
                        size: 14,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Teks
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.penaltiesAndAllowances,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          context.localizeDynamic(
                            item.detail.rincianBannerSubtitle,
                          ),
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Panah Kanan
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: Color(0xFF2563EB),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required Color valueColor,
    required String subtitle,
    required Color subtitleColor,
  }) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: valueColor,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
