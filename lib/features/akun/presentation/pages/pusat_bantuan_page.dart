import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';

class PusatBantuanPage extends StatelessWidget {
  const PusatBantuanPage({super.key});

  static const List<Map<String, String>> _faqItems = [
    {
      'title': 'SOP Presensi Biometrik & Radius GPS',
      'body':
          'Pastikan GPS aktif dan Anda berada dalam radius 50 meter dari titik dapur SPPG saat melakukan Clock-In maupun Clock-Out.',
    },
    {
      'title': 'Prosedur Unggah Surat Keterangan Dokter',
      'body':
          'Untuk pengajuan Izin Sakit, unggah bukti surat dokter maksimal 48 jam sejak tanggal ketidakhadiran melalui menu Cuti & Izin.',
    },
    {
      'title': 'Pengajuan Koreksi Absensi',
      'body':
          'Jika terjadi kendala teknis saat presensi, ajukan koreksi pada halaman Riwayat Absen agar diverifikasi oleh KSPPG.',
    },
    {
      'title': 'Kontak Admin Operasional SPPG',
      'body':
          'WhatsApp Helpdesk: 0811-9000-2401 (Senin–Sabtu, 05:00 - 17:00 WIB) atau email support@sppg.go.id.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 22,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'Pusat Bantuan & SOP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _faqItems.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _faqItems[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['body']!,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textSecondary,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
