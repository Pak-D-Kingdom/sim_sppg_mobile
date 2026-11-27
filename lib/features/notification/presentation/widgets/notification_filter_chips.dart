import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';

class NotificationFilterChips extends StatelessWidget {
  final String selectedFilter;
  final int unreadCount;
  final ValueChanged<String> onFilterChanged;

  const NotificationFilterChips({
    super.key,
    required this.selectedFilter,
    required this.unreadCount,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildChip(
            keyId: 'semua',
            label: unreadCount > 0
                ? l10n.filterAllUnread(unreadCount)
                : l10n.filterAll,
          ),
          const SizedBox(width: 8),
          _buildChip(
            keyId: 'operasional',
            label: l10n.filterOperational,
          ),
          const SizedBox(width: 8),
          _buildChip(
            keyId: 'persetujuan',
            label: l10n.filterApproval,
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String keyId,
    required String label,
  }) {
    final bool isSelected = selectedFilter == keyId;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onFilterChanged(keyId),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accentBlue : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.accentBlue : AppColors.border,
              width: 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.accentBlue.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: Color(0x060F172A),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.onSurface : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
