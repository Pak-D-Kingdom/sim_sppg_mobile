import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/cuti_quota.dart';
import '../../domain/entities/cuti_type.dart';

class CutiQuotaCardWidget extends StatelessWidget {
  final CutiQuota quota;
  final CutiType cutiType;

  const CutiQuotaCardWidget({
    super.key,
    required this.quota,
    required this.cutiType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Quota Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cutiType.quotaTitle,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              Text(
                cutiType == CutiType.cutiTahunan
                    ? quota.quotaUsageText
                    : 'Bebas Kuota',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: cutiType == CutiType.cutiTahunan
                      ? AppColors.textSecondary
                      : const Color(0xFF16A34A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // 2. Horizontal Progress Bar (7/12 for Cuti Tahunan)
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: cutiType == CutiType.cutiTahunan
                    ? quota.usagePercentage
                    : 1.0,
                backgroundColor: const Color(0xFFEFF6FF),
                valueColor: AlwaysStoppedAnimation<Color>(
                  cutiType == CutiType.cutiTahunan
                      ? const Color(0xFF2563EB)
                      : const Color(0xFF10B981),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 3. Info Notice Callout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 1.0),
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 17,
                  color: Color(0xFF2563EB),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  cutiType.infoNote,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
