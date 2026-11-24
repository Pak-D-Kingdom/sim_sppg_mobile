import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/akun_profile.dart';

class AkunKepegawaianCardWidget extends StatelessWidget {
  final AkunProfile profile;

  const AkunKepegawaianCardWidget({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DATA KEPEGAWAIAN & PAYROLL',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          _buildInfoRow(label: 'NIK', value: profile.nik),
          _buildDivider(),
          _buildInfoRow(label: 'Email', value: profile.email),
          _buildDivider(),
          _buildInfoRow(label: 'No. WhatsApp', value: profile.whatsappNumber),
          _buildDivider(),
          _buildInfoRow(label: 'Rekening Gaji', value: profile.payrollAccount),
          _buildDivider(),
          _buildInfoRow(
            label: 'Jadwal Shift Utama',
            value: profile.mainShiftSchedule,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFF1F5F9),
    );
  }
}
