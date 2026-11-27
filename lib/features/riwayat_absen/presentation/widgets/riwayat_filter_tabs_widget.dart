import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';
import '../../domain/entities/riwayat_absen_item.dart';

class RiwayatFilterTabsWidget extends StatelessWidget {
  final RiwayatFilterType selectedFilter;
  final ValueChanged<RiwayatFilterType> onFilterSelected;

  const RiwayatFilterTabsWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  String _localizedLabel(RiwayatFilterType filter, AppLocalizations l10n) {
    switch (filter) {
      case RiwayatFilterType.semua:
        return l10n.filterAll;
      case RiwayatFilterType.hadir:
        return l10n.filterPresent;
      case RiwayatFilterType.telat:
        return l10n.filterLate;
      case RiwayatFilterType.cutiIzin:
        return l10n.filterLeave;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDBEAFE)),
      ),
      child: Row(
        children: RiwayatFilterType.values.map((filter) {
          final isSelected = filter == selectedFilter;
          return Expanded(
            child: GestureDetector(
              onTap: () => onFilterSelected(filter),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accentBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _localizedLabel(filter, l10n),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected
                        ? AppColors.onSurface
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
