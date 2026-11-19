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

  IconData _getIconForCode(String code) {
    switch (code) {
      case 'leave_balance':
        return Icons.edit_calendar_outlined;
      case 'attendance':
        return Icons.check_circle_outline;
      case 'penalty':
        return Icons.shield_outlined;
      default:
        return Icons.analytics_outlined;
    }
  }

  Color _getFooterColor(String code) {
    switch (code) {
      case 'attendance':
        return AppColors.primary;
      case 'leave_balance':
      case 'penalty':
      default:
        return AppColors.tertiary;
    }
  }

  String _getFooterText(HomeStatistic stat) {
    switch (stat.code) {
      case 'leave_balance':
        return 'Tersedia';
      case 'attendance':
        return '90% Target';
      case 'penalty':
        return 'Disiplin Prima';
      default:
        return stat.footer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Ringkasan Bulan Ini',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              Text(
                periodLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // 3-Column Metrics Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(statistics.length, (index) {
              final stat = statistics[index];
              final icon = _getIconForCode(stat.code);
              final footerColor = _getFooterColor(stat.code);
              final footerText = _getFooterText(stat);

              // Concatenate value and unit cleanly (e.g. "5 Hari", "18/20", "Rp 0")
              final String displayValue =
                  stat.unit != null && stat.unit!.isNotEmpty
                      ? (stat.unit!.startsWith('/')
                          ? '${stat.value}${stat.unit}'
                          : '${stat.value} ${stat.unit}')
                      : stat.value;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 5,
                    right: index == statistics.length - 1 ? 0 : 5,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.border,
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x060F172A),
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Centered 32x32 Light Blue Container
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              icon,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Title
                        Text(
                          stat.title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Value
                        Text(
                          displayValue,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Footer Status Text
                        Text(
                          footerText,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: footerColor,
                            height: 1.2,
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
