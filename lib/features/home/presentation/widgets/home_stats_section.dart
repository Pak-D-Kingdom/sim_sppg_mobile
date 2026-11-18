import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/home_statistic.dart';

class HomeStatsSection extends StatelessWidget {
  final List<HomeStatistic> statistics;
  final String periodLabel;

  const HomeStatsSection({
    super.key,
    required this.statistics,
    this.periodLabel = 'November 2026',
  });

  Color _getAccentColor(String code) {
    switch (code) {
      case 'attendance':
        return AppColors.secondary;
      case 'leave_balance':
      case 'penalty':
      default:
        return AppColors.primary;
    }
  }

  Color _getIconBgColor(String code) {
    switch (code) {
      case 'attendance':
        return AppColors.secondarySoft;
      case 'leave_balance':
      case 'penalty':
      default:
        return AppColors.primarySoft;
    }
  }

  IconData _getIconForCode(String code) {
    switch (code) {
      case 'leave_balance':
        return Icons.favorite_border_rounded;
      case 'attendance':
        return Icons.check_box_outlined;
      case 'penalty':
        return Icons.verified_user_rounded;
      default:
        return Icons.analytics_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                'Ringkasan Bulan Ini',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              Text(
                periodLabel,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(statistics.length, (index) {
              final stat = statistics[index];
              final accentColor = _getAccentColor(stat.code);
              final iconBgColor = _getIconBgColor(stat.code);
              final icon = _getIconForCode(stat.code);
              final isPenalty = stat.code == 'penalty';

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 5,
                    right: index == statistics.length - 1 ? 0 : 5,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x060F172A),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: iconBgColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              icon,
                              size: 16,
                              color: accentColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          stat.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Flexible(
                              child: Text(
                                stat.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: isPenalty
                                      ? AppColors.primary
                                      : AppColors.onSurface,
                                ),
                              ),
                            ),
                            if (stat.unit != null && stat.unit!.isNotEmpty) ...[
                              const SizedBox(width: 2),
                              Text(
                                stat.unit!,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          stat.footer,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
