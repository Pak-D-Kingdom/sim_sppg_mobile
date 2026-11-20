import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/jadwal_day.dart';
import '../../domain/entities/jadwal_day_type.dart';

class JadwalDetailCardWidget extends StatelessWidget {
  final JadwalDay day;

  const JadwalDetailCardWidget({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF93C5FD), // Soft blue highlight border
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF93C5FD).withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Date Header & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    day.formattedDisplayDate,
                    key: ValueKey(day.formattedDisplayDate),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
              _buildStatusBadge(day.type),
            ],
          ),
          const SizedBox(height: 12),

          // 2. Shift Title
          Text(
            day.shiftTitle,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 6),

          // 3. Shift Code Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              day.shiftCode,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2563EB),
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // 4. 2x2 Information Grid
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  label: 'Divisi Dapur',
                  value: day.divisiDapur,
                  valueColor: AppColors.onSurface,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildInfoItem(
                  label: 'Jam Shift',
                  value: day.jamShift,
                  valueColor: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  label: 'Toleransi Telat',
                  value: day.toleransiTelat,
                  valueColor: day.toleransiTelat == '–'
                      ? AppColors.textSecondary
                      : const Color(0xFFD97706), // Warm Amber
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildInfoItem(
                  label: 'Status Jadwal',
                  value: day.statusJadwal,
                  valueColor: day.type == JadwalDayType.libur
                      ? AppColors.textSecondary
                      : const Color(0xFF16A34A), // Emerald Green
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(JadwalDayType type) {
    Color bgColor;
    Color textColor;
    String label;

    switch (type) {
      case JadwalDayType.hariKerja:
        bgColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF16A34A);
        label = 'HARI KERJA';
        break;
      case JadwalDayType.libur:
        bgColor = const Color(0xFFF1F5F9);
        textColor = const Color(0xFF64748B);
        label = 'LIBUR';
        break;
      case JadwalDayType.liburSppg:
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFFD97706);
        label = 'LIBUR SPPG';
        break;
      case JadwalDayType.cuti:
        bgColor = const Color(0xFFF3E8FF);
        textColor = const Color(0xFF7C3AED);
        label = 'CUTI TAHUNAN';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
