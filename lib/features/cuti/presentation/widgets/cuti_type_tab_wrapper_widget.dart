import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/cuti_type.dart';

class CutiTypeTabWrapperWidget extends StatelessWidget {
  final CutiType selectedType;
  final ValueChanged<CutiType> onTypeChanged;

  const CutiTypeTabWrapperWidget({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // Light grayish-blue background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        children: [
          // 1. Cuti Tahunan
          _buildTabItem(
            type: CutiType.cutiTahunan,
            label: 'Cuti Tahunan',
          ),

          // 2. Izin Sakit
          _buildTabItem(
            type: CutiType.izinSakit,
            label: 'Izin Sakit',
          ),

          // 3. Izin Darurat
          _buildTabItem(
            type: CutiType.izinDarurat,
            label: 'Izin Darurat',
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required CutiType type,
    required String label,
  }) {
    final isSelected = selectedType == type;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTypeChanged(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected
                    ? AppColors.onSurface
                    : AppColors.textSecondary,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
