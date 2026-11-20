import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sim_sppg_mobile/core/constants/app_colors.dart';
import '../bloc/izin_sakit_bloc.dart';
import '../bloc/izin_sakit_event.dart';
import '../bloc/izin_sakit_state.dart';

class IzinSakitTahap1View extends StatefulWidget {
  final IzinSakitLoaded state;

  const IzinSakitTahap1View({
    super.key,
    required this.state,
  });

  @override
  State<IzinSakitTahap1View> createState() => _IzinSakitTahap1ViewState();
}

class _IzinSakitTahap1ViewState extends State<IzinSakitTahap1View> {
  late final TextEditingController _keluhanController;

  @override
  void initState() {
    super.initState();
    _keluhanController = TextEditingController(text: widget.state.data.keluhan);
  }

  @override
  void didUpdateWidget(covariant IzinSakitTahap1View oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.data.keluhan != widget.state.data.keluhan &&
        _keluhanController.text != widget.state.data.keluhan) {
      _keluhanController.text = widget.state.data.keluhan;
    }
  }

  @override
  void dispose() {
    _keluhanController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final dayStr = date.day.toString().padLeft(2, '0');
    final monthStr = monthNames[date.month - 1];
    return '$dayStr $monthStr ${date.year}';
  }

  Future<void> _selectDate(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime firstDate,
    required ValueChanged<DateTime> onSelected,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2030, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
              onPrimary: Colors.white,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.state.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Ketentuan Izin Sakit Card (Matching Gambar 1)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ketentuan Izin Sakit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Tidak Potong Kuota',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF16A34A),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Icon(
                        Icons.info_outline_rounded,
                        size: 17,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Laporan sakit langsung diteruskan ke KSPPG tanpa memotong kuota tahunan. Halaman unggah bukti sakit akan muncul setelah laporan dikirim (berlaku 2x24 jam).',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 2. Pilih Tanggal Sakit Card (Matching Gambar 1)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Tanggal Sakit',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDateItem(
                      label: 'Tanggal Mulai',
                      dateText: _formatDate(data.startDate),
                      onTap: () => _selectDate(
                        context,
                        initialDate: data.startDate,
                        firstDate: DateTime(2026, 1, 1),
                        onSelected: (date) {
                          context
                              .read<IzinSakitBloc>()
                              .add(UpdateIzinSakitDatesEvent(startDate: date));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDateItem(
                      label: 'Tanggal Selesai',
                      dateText: _formatDate(data.endDate),
                      onTap: () => _selectDate(
                        context,
                        initialDate: data.endDate.isBefore(data.startDate)
                            ? data.startDate
                            : data.endDate,
                        firstDate: data.startDate,
                        onSelected: (date) {
                          context
                              .read<IzinSakitBloc>()
                              .add(UpdateIzinSakitDatesEvent(endDate: date));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2563EB),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '• Durasi: ${data.durationDays} Hari Kerja',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Kuota Cuti: Tetap 5 Hari',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF16A34A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 3. Alasan / Keluhan Sakit Card (Matching Gambar 1)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alasan / Keluhan Sakit',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border, width: 1.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: _keluhanController,
                      maxLines: 4,
                      maxLength: 200,
                      buildCounter: (
                        _, {
                        required currentLength,
                        required isFocused,
                        maxLength,
                      }) =>
                          null,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                        height: 1.45,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Tuliskan keluhan atau gejala sakit...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {});
                        context
                            .read<IzinSakitBloc>()
                            .add(UpdateIzinSakitKeluhanEvent(text));
                      },
                    ),
                    Text(
                      '${_keluhanController.text.length}/200',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // 4. Footer Note & Action Button (Matching Gambar 1)
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
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: data.isSubmitting
                ? null
                : () {
                    context
                        .read<IzinSakitBloc>()
                        .add(const SubmitLaporanSakitEvent());
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9FC5E8),
              foregroundColor: const Color(0xFF0F172A),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: data.isSubmitting
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
                        'Kirim Laporan ke KSPPG',
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

  Widget _buildDateItem({
    required String label,
    required String dateText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 1.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  dateText,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: Color(0xFF2563EB),
            ),
          ],
        ),
      ),
    );
  }
}
