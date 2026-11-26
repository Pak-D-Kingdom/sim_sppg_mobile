import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';

class AkunSettingsCardWidget extends StatelessWidget {
  final VoidCallback onChangePasswordTap;
  final VoidCallback onHelpCenterTap;
  final VoidCallback? onChangeLanguageTap;

  const AkunSettingsCardWidget({
    super.key,
    required this.onChangePasswordTap,
    required this.onHelpCenterTap,
    this.onChangeLanguageTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentLocale = Localizations.localeOf(context).languageCode;
    final currentLanguageBadge = currentLocale == 'en' ? 'EN' : 'ID';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x060F172A),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildActionTile(
            icon: Icons.lock_outline_rounded,
            title: l10n.changePassword,
            subtitle: l10n.changePasswordSubtitle,
            onTap: onChangePasswordTap,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFF1F5F9),
            ),
          ),
          _buildActionTile(
            icon: Icons.help_outline_rounded,
            title: l10n.helpCenter,
            subtitle: l10n.helpCenterSubtitle,
            onTap: onHelpCenterTap,
            borderRadius: onChangeLanguageTap == null
                ? const BorderRadius.vertical(bottom: Radius.circular(18))
                : BorderRadius.zero,
          ),
          if (onChangeLanguageTap != null) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFF1F5F9),
              ),
            ),
            _buildActionTile(
              icon: Icons.language_rounded,
              title: l10n.changeLanguage,
              subtitle: l10n.changeLanguageSubtitle,
              onTap: onChangeLanguageTap!,
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  currentLanguageBadge,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1D5CE6),
                  ),
                ),
              ),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(18)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required BorderRadius borderRadius,
    Widget? trailing,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 20,
                    color: const Color(0xFF1D5CE6),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                trailing,
                const SizedBox(width: 8),
              ],
              const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
