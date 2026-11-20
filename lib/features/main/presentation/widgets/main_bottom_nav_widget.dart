import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';

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
                label: 'Beranda',
                tooltip: 'Beranda',
              ),

              // 2. Jadwal
              _buildNavItem(
                index: 1,
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_today_rounded,
                label: 'Jadwal',
                tooltip: 'Jadwal',
              ),

              // 3. Central Raised Scan Button (Presensi)
              Expanded(
                child: Tooltip(
                  message: 'Presensi',
                  child: GestureDetector(
                    onTap: () => onTap(2),
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: Transform.translate(
                        offset: const Offset(0, -14),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.accentBlue,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x669FC5E8),
                                blurRadius: 14,
                                offset: Offset(0, 6),
                              ),
                              BoxShadow(
                                color: Color(0x409FC5E8),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: FaceScanIcon(
                              size: 26,
                              color: Color(0xFF0F172A),
                              strokeWidth: 2.2,
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
                icon: Icons.receipt_long_outlined,
                activeIcon: Icons.receipt_long_rounded,
                label: 'Payroll',
                tooltip: 'Payroll',
              ),

              // 5. Akun
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                label: 'Akun',
                tooltip: 'Akun',
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
    final Color itemColor = isSelected ? _activeBlue : AppColors.textSecondary;

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
                        size: 22,
                        color: itemColor,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 11,
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

    // Smile: M8 14 s1.5 2 4 2 4-2 4-2
    final smilePath = Path()
      ..moveTo(8 * scale, 14 * scale)
      ..cubicTo(
        9.5 * scale,
        16 * scale,
        10.5 * scale,
        16 * scale,
        12 * scale,
        16 * scale,
      )
      ..cubicTo(
        13.5 * scale,
        16 * scale,
        14.5 * scale,
        16 * scale,
        16 * scale,
        14 * scale,
      );
    canvas.drawPath(smilePath, paint);

    // Two eye dots: (9, 9) and (15, 9)
    canvas.drawCircle(Offset(9 * scale, 9 * scale), 1.15 * scale, dotPaint);
    canvas.drawCircle(Offset(15 * scale, 9 * scale), 1.15 * scale, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _FaceScanPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
