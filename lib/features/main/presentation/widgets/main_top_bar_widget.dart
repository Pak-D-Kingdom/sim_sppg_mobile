import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';

class MainTopBarWidget extends StatelessWidget {
  final String userName;
  final String locationBadge;
  final String? avatarUrl;
  final int unreadNotifications;
  final VoidCallback? onNotificationTap;

  const MainTopBarWidget({
    super.key,
    this.userName = 'Siti Rahmawati, A.Md.Gz',
    this.locationBadge = 'SPPG Rawamangun 01',
    this.avatarUrl =
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCCZQhQXexGtsy7CWarTwSHdYJYow42xsCpiuaYR3ZfloDzk6CJhFbP7Mb8nfaXJ-bciiZ-3W1a-8FQsOwjuGdEBh7I2usstIlj6JunCoKDBkyLlATQmNA6InYJoXEAmfxabN9vg0j1iQRBD5-GyuMDBbzt8qs_mNtEA7Mzu6tCNBwaL2U-_hxNkJ0jRdzrGxugj9f0uAgQD1wh-SjqMQ5dMmP3nL-y6Zs8Tup76Xc',
    this.unreadNotifications = 1,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User Avatar & Badged Info
              Expanded(
                child: Row(
                  children: [
                    // Profile Avatar with Active Status Dot
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x0F0F172A),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: avatarUrl != null && avatarUrl!.isNotEmpty
                                ? Image.network(
                                    avatarUrl!,
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            _buildAvatarFallback(),
                                  )
                                : _buildAvatarFallback(),
                          ),
                        ),
                        // Green Online Badge
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 13,
                            height: 13,
                            decoration: BoxDecoration(
                              color: AppColors.tertiary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),

                    // User Identity & Location Pill
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // User Name
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                              height: 1.25,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),

                          // Location Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDBEAFE),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              locationBadge,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1D5CE6),
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Notification Action Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: onNotificationTap ??
                      () {
                        Navigator.pushNamed(context, AppRoutes.notification);
                      },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE8EEF5),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A0F172A),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(
                          Icons.notifications_none_rounded,
                          size: 21,
                          color: Color(0xFF1E293B),
                        ),
                        if (unreadNotifications > 0)
                          Positioned(
                            top: 8,
                            right: 9,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1D5CE6),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarFallback() {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFDBEAFE), Color(0xFF9FC5E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.person_rounded,
          color: AppColors.onSurface,
          size: 24,
        ),
      ),
    );
  }
}
