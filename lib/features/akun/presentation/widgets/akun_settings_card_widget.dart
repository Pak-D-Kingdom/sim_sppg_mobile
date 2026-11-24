import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';

class AkunSettingsCardWidget extends StatelessWidget {
  final VoidCallback onChangePasswordTap;
  final VoidCallback onHelpCenterTap;

  const AkunSettingsCardWidget({
    super.key,
    required this.onChangePasswordTap,
    required this.onHelpCenterTap,
  });

  @override
  Widget build(BuildContext context) {
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
            title: 'Ubah Kata Sandi',
            subtitle: 'Perbarui keamanan akses akun',
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
            title: 'Pusat Bantuan & SOP',
            subtitle: 'Panduan operasional & kontak admin',
            onTap: onHelpCenterTap,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(18)),
          ),
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
              const SizedBox(width: 8),
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
