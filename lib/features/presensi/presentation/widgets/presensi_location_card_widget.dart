import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';

class PresensiLocationCardWidget extends StatelessWidget {
  final String title;
  final String distance;
  final bool isInRadius;

  const PresensiLocationCardWidget({
    super.key,
    this.title = 'Lokasi Dapur Terverifikasi',
    this.distance = '18m dari titik SPPG Rawamangun 01',
    this.isInRadius = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isInRadius
              ? const Color(0xFFBBF7D0)
              : const Color(0xFFFECACA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Checklist Lokasi
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: isInRadius
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFFEE2E2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                isInRadius
                    ? Icons.check_circle_outline_rounded
                    : Icons.location_off_outlined,
                size: 20,
                color: isInRadius
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFDC2626),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Teks Judul & Jarak
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title == 'Lokasi Dapur Terverifikasi'
                      ? l10n.kitchenLocationVerified
                      : title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  context.localizeDynamic(distance),
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Badge Status Dalam Radius
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isInRadius
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isInRadius
                    ? const Color(0xFFBBF7D0)
                    : const Color(0xFFFECACA),
              ),
            ),
            child: Text(
              isInRadius ? l10n.withinRadius : l10n.outsideRadius,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isInRadius
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFDC2626),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
