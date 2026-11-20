import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';

class CutiFooterButtonWidget extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const CutiFooterButtonWidget({
    super.key,
    this.isSubmitting = false,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Coordinator note with icon
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline_rounded,
              size: 16,
              color: AppColors.textSecondary,
            ),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                'Akan diteruskan ke Koordinator Unit SPPG Rawamangun 01.',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 2. Submit Button matching design
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: isSubmitting ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9FC5E8), // Soft Blue Accent
              foregroundColor: const Color(0xFF0F172A), // Dark text
              elevation: 0,
              disabledBackgroundColor: const Color(0xFFD0E1FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: isSubmitting
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Color(0xFF0F172A),
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kirim Pengajuan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '→',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
