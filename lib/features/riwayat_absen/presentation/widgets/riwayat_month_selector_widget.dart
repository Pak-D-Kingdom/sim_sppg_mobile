import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';

class RiwayatMonthSelectorWidget extends StatelessWidget {
  final String monthLabel;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const RiwayatMonthSelectorWidget({
    super.key,
    required this.monthLabel,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x060F172A),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onPreviousMonth,
            borderRadius: BorderRadius.circular(10),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.chevron_left_rounded,
                size: 20,
                color: Color(0xFF475569),
              ),
            ),
          ),
          Text(
            monthLabel,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
              letterSpacing: -0.2,
            ),
          ),
          InkWell(
            onTap: onNextMonth,
            borderRadius: BorderRadius.circular(10),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
