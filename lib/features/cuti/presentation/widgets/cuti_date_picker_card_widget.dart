import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/cuti_type.dart';

class CutiDatePickerCardWidget extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final int remainingSaldo;
  final CutiType cutiType;
  final ValueChanged<DateTime> onStartDateChanged;
  final ValueChanged<DateTime> onEndDateChanged;

  const CutiDatePickerCardWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.remainingSaldo,
    required this.cutiType,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  String _formatDisplayDate(DateTime date) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final dayStr = date.day.toString().padLeft(2, '0');
    final monthStr = monthNames[date.month - 1];
    return '$dayStr $monthStr ${date.year}';
  }

  Future<void> _selectDate(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime firstDate,
    required ValueChanged<DateTime> onSelected,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2030, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
              onPrimary: Colors.white,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onSelected(picked);
    }
  }

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
          // 1. Title
          const Text(
            'Pilih Tanggal Pengajuan',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),

          // 2. Start & End Date Boxes
          Row(
            children: [
              // Tanggal Mulai
              Expanded(
                child: _buildDateBox(
                  label: 'Tanggal Mulai',
                  dateText: _formatDisplayDate(startDate),
                  onTap: () => _selectDate(
                    context,
                    initialDate: startDate,
                    firstDate: DateTime(2026, 1, 1),
                    onSelected: onStartDateChanged,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Tanggal Selesai
              Expanded(
                child: _buildDateBox(
                  label: 'Tanggal Selesai',
                  dateText: _formatDisplayDate(endDate),
                  onTap: () => _selectDate(
                    context,
                    initialDate: endDate.isBefore(startDate) ? startDate : endDate,
                    firstDate: startDate,
                    onSelected: onEndDateChanged,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 3. Summary Pill (Durasi & Sisa Saldo)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF), // Soft blue callout
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Durasi
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Durasi: $durationDays Hari Kerja',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ],
                ),

                // Sisa Saldo
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: cutiType == CutiType.cutiTahunan
                            ? 'Sisa Saldo: '
                            : 'Saldo Tetap: ',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '$remainingSaldo Hari',
                        style: const TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateBox({
    required String label,
    required String dateText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 1.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  dateText,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: Color(0xFF2563EB),
            ),
          ],
        ),
      ),
    );
  }
}
