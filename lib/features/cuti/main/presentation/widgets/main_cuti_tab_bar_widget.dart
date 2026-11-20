import 'package:material_ui/material_ui.dart';
import '../../domain/entities/cuti_tab_type.dart';

class MainCutiTabBarWidget extends StatelessWidget {
  final CutiTabType currentTab;
  final ValueChanged<CutiTabType> onTabSelected;

  const MainCutiTabBarWidget({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: CutiTabType.values.map((tab) {
          final isSelected = tab == currentTab;
          return Expanded(
            child: InkWell(
              onTap: () => onTabSelected(tab),
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    tab.label,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF0F172A)
                          : const Color(0xFF64748B),
                    ),
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
