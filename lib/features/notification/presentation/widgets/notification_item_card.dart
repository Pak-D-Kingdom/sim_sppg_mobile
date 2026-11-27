import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';
import '../../domain/entities/app_notification.dart';

class NotificationItemCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback? onTap;

  const NotificationItemCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  IconData _getCategoryIcon(String category) {
    if (category.contains('OPERASIONAL') || category.contains('PEST')) {
      return Icons.pest_control_outlined;
    } else if (category.contains('CUTI')) {
      return Icons.calendar_month_outlined;
    } else if (category.contains('PRESENSI')) {
      return Icons.check_circle_outline_rounded;
    }
    return Icons.notifications_none_outlined;
  }

  Color _getCategoryColor(String category) {
    if (category.contains('PRESENSI')) {
      return AppColors.success;
    }
    return AppColors.primary;
  }

  Color _getIconBgColor(String category) {
    if (category.contains('PRESENSI')) {
      return AppColors.successLight;
    }
    return const Color(0xFFD0E1FB);
  }

  Color _getIconColor(String category) {
    if (category.contains('PRESENSI')) {
      return AppColors.success;
    }
    return const Color(0xFF1E293B);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bool isUnread = !notification.isRead;
    final Color categoryColor = _getCategoryColor(notification.category);
    final Color iconBg = _getIconBgColor(notification.category);
    final Color iconColor = _getIconColor(notification.category);
    final IconData iconData = _getCategoryIcon(notification.category);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: isUnread ? const Color(0xFFF6F9FE) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isUnread
                    ? const Color(0xFF93C5FD)
                    : AppColors.border,
                width: isUnread ? 1.2 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isUnread
                      ? const Color(0x0A0058BE)
                      : const Color(0x060F172A),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Header Row
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: iconBg,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          iconData,
                          size: 17,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        notification.category,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: categoryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Title
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                    height: 1.25,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 6),

                // Description
                Text(
                  notification.description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF475569),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),

                // Footer (Timestamp and Read Status)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notification.timestamp,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (isUnread)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.unread,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '●',
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_rounded,
                            size: 14,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            l10n.read,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
