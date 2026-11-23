import 'package:material_ui/material_ui.dart';
import '../../domain/entities/presensi_data.dart';

class PresensiTimeInfoWidget extends StatelessWidget {
  final PresensiType type;
  final String text;
  final String badge;

  const PresensiTimeInfoWidget({
    super.key,
    required this.type,
    required this.text,
    this.badge = '',
  });

  @override
  Widget build(BuildContext context) {
    final isClockIn = type == PresensiType.clockIn;
    final trimmedBadge = badge.trim();
    final showBadge = isClockIn && trimmedBadge.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.access_time_rounded,
            size: 17,
            color: Color(0xFF2563EB),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          if (showBadge) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFFDE68A),
                ),
              ),
              child: Text(
                trimmedBadge,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFB45309),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
