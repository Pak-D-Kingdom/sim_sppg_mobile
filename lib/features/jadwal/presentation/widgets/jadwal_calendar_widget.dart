import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';
import '../../domain/entities/jadwal_day.dart';
import '../../domain/entities/jadwal_day_type.dart';

class JadwalCalendarWidget extends StatelessWidget {
  final String currentMonthYear;
  final int currentMonth;
  final int currentYear;
  final List<JadwalDay> days;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectDate;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final bool isLoading;

  const JadwalCalendarWidget({
    super.key,
    required this.currentMonthYear,
    required this.currentMonth,
    required this.currentYear,
    required this.days,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onPreviousMonth,
    required this.onNextMonth,
    this.isLoading = false,
  });

  Color _getDotColor(JadwalDayType type) {
    switch (type) {
      case JadwalDayType.hariKerja:
        return const Color(0xFF10B981); // Emerald Green
      case JadwalDayType.libur:
        return const Color(0xFF94A3B8); // Slate Grey
      case JadwalDayType.liburSppg:
        return const Color(0xFFEA580C); // Orange
      case JadwalDayType.cuti:
        return const Color(0xFF8B5CF6); // Purple
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final weekdays = [
      l10n.daySun,
      l10n.dayMon,
      l10n.dayTue,
      l10n.dayWed,
      l10n.dayThu,
      l10n.dayFri,
      l10n.daySat,
    ];
    // Determine the weekday of the 1st day of the month
    // DateTime.weekday: 1 = Mon, 7 = Sun. We want 0 = Sun (Min), 6 = Sat (Sab)
    final firstDayOfMonth = DateTime(currentYear, currentMonth, 1);
    final int startOffset = firstDayOfMonth.weekday % 7;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // 1. Month Header & Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded, size: 22),
                color: isLoading
                    ? AppColors.textSecondary.withValues(alpha: 0.3)
                    : AppColors.onSurface,
                onPressed: isLoading ? null : onPreviousMonth,
                visualDensity: VisualDensity.compact,
                splashRadius: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.localizeDynamic(currentMonthYear),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                    ),
                  ),
                  if (isLoading) ...[
                    const SizedBox(width: 8),
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                      ),
                    ),
                  ],
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded, size: 22),
                color: isLoading
                    ? AppColors.textSecondary.withValues(alpha: 0.3)
                    : AppColors.onSurface,
                onPressed: isLoading ? null : onNextMonth,
                visualDensity: VisualDensity.compact,
                splashRadius: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 2. Day of Week Labels
          Row(
            children: weekdays.map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),

          // 3. Dates Grid with smooth opacity during month change
          AnimatedOpacity(
            opacity: isLoading ? 0.35 : 1.0,
            duration: const Duration(milliseconds: 180),
            child: _buildDatesGrid(startOffset),
          ),

          const SizedBox(height: 14),
          const Divider(color: Color(0xFFF1F5F9), height: 1),
          const SizedBox(height: 12),

          // 4. Legend Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem(const Color(0xFF10B981), l10n.workDay),
              _buildLegendItem(const Color(0xFF94A3B8), l10n.dayOff),
              _buildLegendItem(const Color(0xFFEA580C), l10n.sppgHoliday),
              _buildLegendItem(const Color(0xFF8B5CF6), l10n.leave),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatesGrid(int startOffset) {
    final List<Widget> gridCells = [];

    // Empty cells before the 1st of the month
    for (int i = 0; i < startOffset; i++) {
      gridCells.add(const SizedBox());
    }

    final now = DateTime.now();
    final bool isCurrentMonth =
        currentYear == now.year && currentMonth == now.month;
    final int todayDay = isCurrentMonth
        ? now.day
        : (currentMonth == 11 && currentYear == 2026 ? 20 : -1);

    // Actual day cells
    for (final day in days) {
      final isSelected = day.date.year == selectedDate.year &&
          day.date.month == selectedDate.month &&
          day.date.day == selectedDate.day;

      final isToday = day.dayNumber == todayDay;
      final dotColor = _getDotColor(day.type);

      // Sesuai permintaan user:
      // 1. Saat di-klik: active indicator aktif menjadi biru
      // 2. Saat hari ini tidak aktif / tidak di-klik: lingkaran tepi biru, tengah putih
      BoxDecoration circleDecoration;
      Color textColor;

      if (isSelected) {
        circleDecoration = BoxDecoration(
          color: const Color(0xFFB9D7F4),
          shape: BoxShape.circle,
          border: isToday
              ? Border.all(color: const Color(0xFF2563EB), width: 1.5)
              : null,
        );
        textColor = AppColors.onSurface;
      } else if (isToday) {
        circleDecoration = BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF2563EB),
            width: 1.5,
          ),
        );
        textColor = const Color(0xFF2563EB);
      } else {
        circleDecoration = const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        );
        textColor = AppColors.onSurface;
      }

      gridCells.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onSelectDate(day.date),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeInOut,
                  width: 32,
                  height: 32,
                  decoration: circleDecoration,
                  child: Center(
                    child: Text(
                      '${day.dayNumber}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: (isSelected || isToday)
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 5.5,
                  height: 5.5,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Grid layout with 7 columns
    final List<Widget> rows = [];
    for (int i = 0; i < gridCells.length; i += 7) {
      final end = (i + 7 < gridCells.length) ? i + 7 : gridCells.length;
      final rowCells = gridCells.sublist(i, end);

      // Pad remaining cells in the last row to maintain equal spacing
      while (rowCells.length < 7) {
        rowCells.add(const SizedBox());
      }

      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: rowCells.map((cell) => Expanded(child: cell)).toList(),
          ),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7.5,
          height: 7.5,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

/// Alias agar komponen CalendarView dapat dipanggil dengan nama CalendarView
typedef CalendarView = JadwalCalendarWidget;
typedef JadwalCalendarView = JadwalCalendarWidget;

