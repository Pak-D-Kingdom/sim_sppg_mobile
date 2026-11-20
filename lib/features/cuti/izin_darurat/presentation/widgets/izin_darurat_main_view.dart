import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sim_sppg_mobile/core/constants/app_colors.dart';
import 'package:sim_sppg_mobile/injection_container.dart';
import '../bloc/izin_darurat_bloc.dart';
import '../bloc/izin_darurat_event.dart';
import '../bloc/izin_darurat_state.dart';

class IzinDaruratMainView extends StatelessWidget {
  const IzinDaruratMainView({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      context.read<IzinDaruratBloc>();
      return const _IzinDaruratContent();
    } catch (_) {
      return BlocProvider(
        create: (_) =>
            sl<IzinDaruratBloc>()..add(const LoadIzinDaruratInitialEvent()),
        child: const _IzinDaruratContent(),
      );
    }
  }
}

class _IzinDaruratContent extends StatefulWidget {
  const _IzinDaruratContent();

  @override
  State<_IzinDaruratContent> createState() => _IzinDaruratContentState();
}

class _IzinDaruratContentState extends State<_IzinDaruratContent> {
  late final TextEditingController _alasanController;

  static const List<String> _kategoriList = [
    'Keluarga Sakit Kritis',
    'Duka Cita',
    'Bencana Alam',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    _alasanController =
        TextEditingController(text: 'Keluarga inti masuk IGD mendadak.');
  }

  @override
  void dispose() {
    _alasanController.dispose();
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
    return BlocConsumer<IzinDaruratBloc, IzinDaruratState>(
      listener: (context, state) {
        if (state is IzinDaruratLoaded) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: const Color(0xFF16A34A),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        if (state is IzinDaruratLoading || state is IzinDaruratInitial) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is IzinDaruratError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: AppColors.error),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<IzinDaruratBloc>()
                        .add(const LoadIzinDaruratInitialEvent()),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        final loadedState = state as IzinDaruratLoaded;
        final data = loadedState.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Ketentuan Izin Darurat Card
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
                        'Ketentuan Izin Darurat',
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
                          'Bebas Kuota',
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
                            'Laporan izin darurat dapat diajukan pada hari-H untuk keadaan mendesak (duka cita, musibah keluarga, dsb) tanpa memotong kuota tahunan.',
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

            // 2. Pilih Tanggal Pengajuan Card
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
                    'Pilih Tanggal Pengajuan',
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
                              final newEnd =
                                  date.isAfter(data.endDate) ? date : data.endDate;
                              context.read<IzinDaruratBloc>().add(
                                    ChangeIzinDaruratDateRangeEvent(
                                      startDate: date,
                                      endDate: newEnd,
                                    ),
                                  );
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
                            initialDate: data.endDate,
                            firstDate: data.startDate,
                            onSelected: (date) {
                              context.read<IzinDaruratBloc>().add(
                                    ChangeIzinDaruratDateRangeEvent(
                                      startDate: data.startDate,
                                      endDate: date,
                                    ),
                                  );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
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
                            const SizedBox(width: 8),
                            Text(
                              'Durasi: ${data.durationDays} Hari Kerja',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1D4ED8),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Bebas Potong Saldo',
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

            // 3. Kategori Kedaruratan Card
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
                    'Kategori Kedaruratan',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _kategoriList.map((kat) {
                      final isSelected = kat == data.kategori;
                      return InkWell(
                        onTap: () {
                          context
                              .read<IzinDaruratBloc>()
                              .add(ChangeIzinDaruratKategoriEvent(kat));
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF2563EB)
                                : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2563EB)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Text(
                            kat,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.onSurface,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 4. Alasan / Keterangan Card & Lampiran
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
                    'Alasan / Keterangan',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _alasanController,
                          maxLines: 3,
                          maxLength: 200,
                          onChanged: (val) {
                            context
                                .read<IzinDaruratBloc>()
                                .add(ChangeIzinDaruratAlasanEvent(val));
                            setState(() {});
                          },
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: 'Jelaskan kondisi darurat secara singkat...',
                            hintStyle: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12.5,
                            ),
                            counterText: '',
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '${_alasanController.text.length}/200',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF94A3B8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Lampirkan Bukti (Opsional)',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      final bloc = context.read<IzinDaruratBloc>();
                      if (data.attachmentName != null) {
                        bloc.add(const ChangeIzinDaruratAttachmentEvent(null));
                      } else {
                        bloc.add(const ChangeIzinDaruratAttachmentEvent(
                            'surat_keterangan_darurat.pdf'));
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF93C5FD),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            data.attachmentName != null
                                ? Icons.check_circle_outline_rounded
                                : Icons.file_upload_outlined,
                            size: 26,
                            color: data.attachmentName != null
                                ? const Color(0xFF16A34A)
                                : const Color(0xFF2563EB),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            data.attachmentName ??
                                'Opsional untuk izin darurat • Dokumen dapat menyusul',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: data.attachmentName != null
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: data.attachmentName != null
                                  ? const Color(0xFF16A34A)
                                  : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            '(JPG, PNG, PDF • Maks. 2MB)',
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Notice Footer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.person_outline_rounded,
                    size: 16,
                    color: AppColors.textSecondary.withValues(alpha: 0.8),
                  ),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      'Akan diteruskan ke Koordinator Unit SPPG Rawamangun 01.',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: data.isSubmitting
                    ? null
                    : () {
                        context
                            .read<IzinDaruratBloc>()
                            .add(const SubmitIzinDaruratEvent());
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF93C5FD),
                  foregroundColor: const Color(0xFF0F172A),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: data.isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF0F172A),
                          ),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Kirim Pengajuan Darurat',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_rounded, size: 16),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildDateItem({
    required String label,
    required String dateText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    dateText,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: Color(0xFF2563EB),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
