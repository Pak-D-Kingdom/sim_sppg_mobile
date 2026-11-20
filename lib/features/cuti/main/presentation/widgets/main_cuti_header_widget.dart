import 'package:material_ui/material_ui.dart';
import '../../../../../core/constants/app_colors.dart';

class MainCutiHeaderWidget extends StatelessWidget {
  final VoidCallback? onBackTap;
  final String title;

  const MainCutiHeaderWidget({
    super.key,
    this.onBackTap,
    this.title = 'Pengajuan Cuti & Izin',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          InkWell(
            onTap: onBackTap ?? () => Navigator.of(context).maybePop(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: AppColors.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
