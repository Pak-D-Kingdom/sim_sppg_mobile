import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/home_statistic.dart';
import '../../domain/entities/today_attendance.dart';

class HomeAttendanceCardWidget extends StatelessWidget {
  final TodayAttendance attendance;
  final List<HomeStatistic>? statistics;
  final VoidCallback? onClockInTap;
  final VoidCallback? onClockOutTap;

  const HomeAttendanceCardWidget({
    super.key,
    required this.attendance,
    this.statistics,
    this.onClockInTap,
    this.onClockOutTap,
  });

  static const List<HomeStatistic> _defaultStatistics = [
    HomeStatistic(
      id: '1',
      title: 'Saldo Cuti',
      value: '5',
      unit: 'Hari',
      footer: 'Tersedia',
      code: 'leave_balance',
    ),
    HomeStatistic(
      id: '2',
      title: 'Kehadiran',
      value: '18',
      unit: '/20',
      footer: '90% Target',
      code: 'attendance',
    ),
    HomeStatistic(
      id: '3',
      title: 'Denda Telat',
      value: 'Rp 0',
      footer: 'Disiplin Prima',
      code: 'penalty',
    ),
  ];

  String _getDisplayValue(HomeStatistic stat) {
    if (stat.unit != null && stat.unit!.isNotEmpty) {
      if (stat.unit!.startsWith('/')) {
        return '${stat.value}${stat.unit}';
      }
      return '${stat.value} ${stat.unit}';
    }
    return stat.value;
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
        return stat.footer.isNotEmpty ? stat.footer : 'Tersedia';
    }
  }

  Color _getFooterColor(String code) {
    switch (code) {
      case 'attendance':
        return const Color(0xFF2563EB); // Vibrant info blue as in design
      case 'leave_balance':
      case 'penalty':
      default:
        return const Color(0xFF15803D); // Forest green as in design
    }
  }

  Color _getCardBgColor(String code) {
    switch (code) {
      case 'leave_balance':
        return const Color(0xFFF0F7FF);
      case 'attendance':
        return const Color(0xFFF1F5FF);
      case 'penalty':
        return const Color(0xFFECFDF5);
      default:
        return Colors.white;
    }
  }

  Color _getCardBorderColor(String code) {
    switch (code) {
      case 'leave_balance':
        return const Color(0xFFBFDBFE);
      case 'attendance':
        return const Color(0xFFC7D2FE);
      case 'penalty':
        return const Color(0xFFA7F3D0);
      default:
        return AppColors.border;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Standardize formatted date to single line if containing newlines
    final String displayDate = attendance.dateFormatted.replaceAll('\n', ' ');
    final stats = (statistics != null && statistics!.isNotEmpty)
        ? statistics!
        : _defaultStatistics;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // 1. Vibrant Royal Blue Hero Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1F65ED), Color(0xFF1A56E0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x331D5CE6),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row: Translucent Calendar Box + Date & Shift Subtitle
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.22),
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.calendar_today_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayDate,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            attendance.shiftSchedule,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.88),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Subtle Translucent Divider
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),

                // Clock-In & Clock-Out Twin White Cards
                Row(
                  children: [
                    // Clock-In Card
                    Expanded(
                      child: InkWell(
                        onTap: onClockInTap,
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x140F172A),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'CLOCK-IN',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    attendance.clockInTime,
                                    style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.onSurface,
                                      height: 1.1,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  const Text(
                                    'WIB',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3.5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.successLight,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.success,
                                        height: 1.0,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Tepat Waktu',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.success,
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

                    const SizedBox(width: 12),

                    // Clock-Out Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x140F172A),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'CLOCK-OUT',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  attendance.isClockedOut
                                      ? attendance.clockOutTime
                                      : '--:--',
                                  style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.onSurface,
                                    height: 1.1,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Text(
                                  'WIB',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3.5,
                              ),
                              decoration: BoxDecoration(
                                color: attendance.isClockedOut
                                    ? AppColors.successLight
                                    : AppColors.warningLight,
                                borderRadius: BorderRadius.circular(999),
                                border: attendance.isClockedOut
                                    ? null
                                    : Border.all(
                                        color: AppColors.warningBorder,
                                        width: 1,
                                      ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '•',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: attendance.isClockedOut
                                          ? AppColors.success
                                          : AppColors.warning,
                                      height: 1.0,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    attendance.isClockedOut
                                        ? 'Selesai'
                                        : 'Menunggu',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: attendance.isClockedOut
                                          ? AppColors.success
                                          : AppColors.warning,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // White Primary Clock-out Action Button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: attendance.isClockedOut ? null : onClockOutTap,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x140F172A),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            attendance.isClockedOut
                                ? Icons.check_circle_outline
                                : Icons.logout_rounded,
                            size: 19,
                            color: AppColors.onSurface,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            attendance.isClockedOut
                                ? 'Presensi Selesai'
                                : 'Clock-Out Sekarang (Pulang)',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // 2. Separate 3 Pastel Summary Metric Cards Row (Saldo Cuti, Kehadiran, Denda Telat)
          Row(
            children: List.generate(stats.length, (index) {
              final stat = stats[index];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 4,
                    right: index == stats.length - 1 ? 0 : 4,
                  ),
                  child: _buildMetricItem(
                    title: stat.title,
                    value: _getDisplayValue(stat),
                    footer: _getFooterText(stat),
                    footerColor: _getFooterColor(stat.code),
                    bgColor: _getCardBgColor(stat.code),
                    borderColor: _getCardBorderColor(stat.code),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required String title,
    required String value,
    required String footer,
    required Color footerColor,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
              height: 1.15,
              letterSpacing: -0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            footer,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: footerColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
