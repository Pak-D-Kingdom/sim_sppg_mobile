import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';

class PayrollFilterYearWidget extends StatelessWidget {
  final int selectedYear;
  final List<int> availableYears;
  final ValueChanged<int> onYearSelected;

  const PayrollFilterYearWidget({
    super.key,
    required this.selectedYear,
    required this.availableYears,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          l10n.payslipList,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.onSurface,
            letterSpacing: -0.2,
          ),
        ),
        PopupMenuButton<int>(
          onSelected: onYearSelected,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          itemBuilder: (context) {
            return availableYears.map((year) {
              final isCurrent = year == selectedYear;
              return PopupMenuItem<int>(
                value: year,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.yearLabel(year),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            isCurrent ? FontWeight.w800 : FontWeight.w500,
                        color: isCurrent
                            ? const Color(0xFF2563EB)
                            : AppColors.onSurface,
                      ),
                    ),
                    if (isCurrent)
                      const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Color(0xFF2563EB),
                      ),
                  ],
                ),
              );
            }).toList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFBFDBFE)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.yearLabel(selectedYear),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: Color(0xFF2563EB),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
