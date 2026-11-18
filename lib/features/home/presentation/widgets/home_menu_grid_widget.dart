import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/home_menu.dart';

class HomeMenuGridWidget extends StatelessWidget {
  final List<HomeMenu> menus;
  final Function(HomeMenu menu)? onMenuTap;

  const HomeMenuGridWidget({
    super.key,
    required this.menus,
    this.onMenuTap,
  });

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'gps':
        return Icons.location_on_outlined;
      case 'koreksi':
        return Icons.event_available_outlined;
      case 'cuti':
        return Icons.date_range_outlined;
      case 'jadwal':
        return Icons.calendar_month_outlined;
      case 'payroll':
        return Icons.receipt_long_outlined;
      case 'approval':
        return Icons.task_outlined;
      default:
        return Icons.grid_view_rounded;
    }
  }

  Color _getIconColor(String theme) {
    switch (theme) {
      case 'blue':
        return AppColors.secondary;
      case 'amber':
        return AppColors.tertiary;
      case 'red':
        return AppColors.error;
      case 'green':
      default:
        return AppColors.primary;
    }
  }

  Color _getIconBgColor(String theme) {
    switch (theme) {
      case 'blue':
        return AppColors.secondarySoft;
      case 'amber':
        return const Color(0xFFFFF3E6);
      case 'red':
        return AppColors.errorSoft;
      case 'green':
      default:
        return AppColors.primarySoft;
    }
  }

  Widget _buildBadge(String badgeText, String theme) {
    final bool isUrgentRed = theme == 'red';
    final Color bgColor = isUrgentRed
        ? AppColors.error
        : (theme == 'blue' ? AppColors.secondarySoft : AppColors.primarySoft);
    final Color textColor = isUrgentRed
        ? Colors.white
        : (theme == 'blue' ? AppColors.secondary : AppColors.primary);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        badgeText,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                'Layanan Mandiri Personel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              Text(
                '${menus.length} Modul Utama',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menus.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.42,
            ),
            itemBuilder: (context, index) {
              final menu = menus[index];
              final iconColor = _getIconColor(menu.theme);
              final iconBgColor = _getIconBgColor(menu.theme);

              return Material(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    if (onMenuTap != null) {
                      onMenuTap!(menu);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Membuka modul: ${menu.title}'),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x060F172A),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: iconBgColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  _getIconData(menu.icon),
                                  color: iconColor,
                                  size: 20,
                                ),
                              ),
                            ),
                            if (menu.badgeText != null &&
                                menu.badgeText!.isNotEmpty)
                              _buildBadge(menu.badgeText!, menu.theme),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              menu.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
