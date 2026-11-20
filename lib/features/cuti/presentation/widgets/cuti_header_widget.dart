import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';

class CutiHeaderWidget extends StatelessWidget {
  final VoidCallback? onBackTap;

  const CutiHeaderWidget({
    super.key,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          // Circular Back Button matching the design
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onBackTap ?? () => Navigator.maybePop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: AppColors.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Header Title
          const Text(
            'Pengajuan Cuti & Izin',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}
