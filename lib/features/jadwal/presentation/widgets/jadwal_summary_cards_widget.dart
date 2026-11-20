import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/jadwal_summary.dart';

class JadwalSummaryCardsWidget extends StatelessWidget {
  final JadwalSummary summary;

  const JadwalSummaryCardsWidget({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Hari Kerja
        Expanded(
          child: _buildSummaryCard(
            title: 'HARI KERJA',
            value: '${summary.hariKerja} Hari',
            valueColor: AppColors.onSurface,
          ),
        ),
        const SizedBox(width: 10),

        // 2. Libur / Off
        Expanded(
          child: _buildSummaryCard(
            title: 'LIBUR / OFF',
            value: '${summary.liburOff} Hari',
            valueColor: const Color(0xFF2563EB),
          ),
        ),
        const SizedBox(width: 10),

        // 3. Kuota Cuti
        Expanded(
          child: _buildSummaryCard(
            title: 'KUOTA CUTI',
            value: summary.kuotaCuti,
            valueColor: const Color(0xFF7C3AED),
            subtitle: summary.sisaCuti,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.ajukanCuti);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required Color valueColor,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    final cardContent = Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 0.3,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: valueColor,
              letterSpacing: -0.2,
              height: 1.15,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 3),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
                height: 1.15,
              ),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: cardContent,
      );
    }

    return cardContent;
  }
}
