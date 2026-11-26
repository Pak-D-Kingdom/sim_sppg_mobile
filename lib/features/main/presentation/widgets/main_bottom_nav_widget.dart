import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';

class MainBottomNavWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const Color _activeBlue = Color(0xFF2563EB);

  const MainBottomNavWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: const Border(
          top: BorderSide(
            color: Color(0xFFF1F5F9),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Beranda
              _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: l10n.home,
                tooltip: l10n.home,
              ),

              // 2. Jadwal
              _buildNavItem(
                index: 1,
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_today_rounded,
                label: l10n.schedule,
                tooltip: l10n.schedule,
              ),

              // 3. Central Raised Scan Button (Presensi) dengan 3 Lingkaran Konsentris
              Expanded(
                child: Tooltip(
                  message: l10n.attendance,
                  child: GestureDetector(
                    onTap: () => onTap(2),
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: Transform.translate(
                        offset: const Offset(0, -16),
                        child: Container(
                          // Lingkaran 1: Paling Luar (Outer Ring - #C7DCF4)
                          width: 76,
                          height: 76,
                          decoration: const BoxDecoration(
                            color: Color(0xFFC7DCF4),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x409FC5E8),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              // Lingkaran 2: Tengah (Middle Ring - #9FC5E8)
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: Color(0xFF9FC5E8),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  // Lingkaran 3: Paling Dalam (Core Solid Button - #2563EB)
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: _activeBlue,
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF2B70FF),
                                        Color(0xFF1D5DE6),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF1D4ED8).withValues(alpha: 0.35),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: FaceScanIcon(
                                      size: 26,
                                      color: Colors.white,
                                      strokeWidth: 2.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 4. Payroll
              _buildNavItem(
                index: 3,
                icon: Icons.credit_card_outlined,
                activeIcon: Icons.credit_card_rounded,
                label: l10n.payroll,
                tooltip: l10n.payroll,
              ),

              // 5. Akun
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                label: l10n.account,
                tooltip: l10n.account,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required String tooltip,
  }) {
    final bool isSelected = currentIndex == index;
    final Color itemColor = isSelected ? _activeBlue : const Color(0xFF64748B);

    return Expanded(
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: () => onTap(index),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: SizedBox(
            height: 62,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Indikator garis atas saat menu aktif (dipilih)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width: isSelected ? 34 : 0,
                  height: 3.5,
                  decoration: BoxDecoration(
                    color: isSelected ? _activeBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Icon dan label navigasi
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isSelected ? activeIcon : icon,
                        size: 23,
                        color: itemColor,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: itemColor,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter to replicate the precise SVG Face / Biometric Scan icon
class FaceScanIcon extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const FaceScanIcon({
    super.key,
    this.size = 28,
    this.color = const Color(0xFF0F172A),
    this.strokeWidth = 2.2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _FaceScanPainter(color: color, strokeWidth: strokeWidth),
    );
  }
}

class _FaceScanPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _FaceScanPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth * scale
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Top-left bracket: M3 7 V5 a2 2 0 0 1 2-2 h2
    final tlPath = Path()
      ..moveTo(3 * scale, 7 * scale)
      ..lineTo(3 * scale, 5 * scale)
      ..arcToPoint(
        Offset(5 * scale, 3 * scale),
        radius: Radius.circular(2 * scale),
      )
      ..lineTo(7 * scale, 3 * scale);
    canvas.drawPath(tlPath, paint);

    // Top-right bracket: M17 3 h2 a2 2 0 0 1 2 2 v2
    final trPath = Path()
      ..moveTo(17 * scale, 3 * scale)
      ..lineTo(19 * scale, 3 * scale)
      ..arcToPoint(
        Offset(21 * scale, 5 * scale),
        radius: Radius.circular(2 * scale),
      )
      ..lineTo(21 * scale, 7 * scale);
    canvas.drawPath(trPath, paint);

    // Bottom-right bracket: M21 17 v2 a2 2 0 0 1 -2 2 h-2
    final brPath = Path()
      ..moveTo(21 * scale, 17 * scale)
      ..lineTo(21 * scale, 19 * scale)
      ..arcToPoint(
        Offset(19 * scale, 21 * scale),
        radius: Radius.circular(2 * scale),
      )
      ..lineTo(17 * scale, 21 * scale);
    canvas.drawPath(brPath, paint);

    // Bottom-left bracket: M7 21 H5 a2 2 0 0 1 -2-2 v-2
    final blPath = Path()
      ..moveTo(7 * scale, 21 * scale)
      ..lineTo(5 * scale, 21 * scale)
      ..arcToPoint(
        Offset(3 * scale, 19 * scale),
        radius: Radius.circular(2 * scale),
      )
      ..lineTo(3 * scale, 17 * scale);
    canvas.drawPath(blPath, paint);

    // Smile: smooth happy smile
    final smilePath = Path()
      ..moveTo(8.5 * scale, 13.8 * scale)
      ..cubicTo(
        9.6 * scale,
        16.5 * scale,
        14.4 * scale,
        16.5 * scale,
        15.5 * scale,
        13.8 * scale,
      );
    canvas.drawPath(smilePath, paint);

    // Two eye dots: (9.0, 9.2) and (15.0, 9.2)
    canvas.drawCircle(Offset(9.0 * scale, 9.2 * scale), 1.5 * scale, dotPaint);
    canvas.drawCircle(Offset(15.0 * scale, 9.2 * scale), 1.5 * scale, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _FaceScanPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
