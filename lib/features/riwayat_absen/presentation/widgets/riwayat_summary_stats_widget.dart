import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';

class RiwayatSummaryStatsWidget extends StatelessWidget {
  final int hadirCount;
  final int telatCount;
  final int cutiIzinCount;
  final int menungguCount;

  const RiwayatSummaryStatsWidget({
    super.key,
    required this.hadirCount,
    required this.telatCount,
    required this.cutiIzinCount,
    required this.menungguCount,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            label: l10n.presentUpper,
            value: hadirCount.toString(),
            valueColor: const Color(0xFF15803D),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            label: l10n.lateUpper,
            value: telatCount.toString(),
            valueColor: const Color(0xFFB45309),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            label: l10n.leaveUpper,
            value: cutiIzinCount.toString(),
            valueColor: const Color(0xFF7C3AED),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            label: l10n.waitingUpper,
            value: menungguCount.toString(),
            valueColor: const Color(0xFF1D5CE6),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x060F172A),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: valueColor,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
