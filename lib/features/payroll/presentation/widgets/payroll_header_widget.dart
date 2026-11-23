import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';

class PayrollHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;

  const PayrollHeaderWidget({
    super.key,
    this.title = 'Payroll',
    this.subtitle = 'SPPG Rawamangun 01 • Closing Tgl 25',
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          if (showBackButton) ...[
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.maybePop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: AppColors.onSurface,
                ),
              ),
            ),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
