import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sim_sppg_mobile/core/constants/app_colors.dart';
import 'package:sim_sppg_mobile/core/localization/app_localizations_extension.dart';
import 'package:sim_sppg_mobile/injection_container.dart';
import '../../domain/entities/izin_darurat_entity.dart';
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
    'Keluarga Rawat Darurat',
    'Kendaraan Mogok',
    'Banjir / Bencana Alam',
    'Duka Cita',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    _alasanController =
        TextEditingController(text: 'Anggota keluarga inti masuk IGD RSUD pagi ini.');
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

  String _formatTerlambatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMins = minutes % 60;
    if (hours > 0 && remainingMins > 0) {
      return '$hours jam $remainingMins menit';
    } else if (hours > 0) {
      return '$hours jam';
    } else {
      return '$remainingMins menit';
    }
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

  Future<void> _selectTime(BuildContext context, IzinDaruratData data) async {
    final parts = data.jamTiba.replaceAll(' WIB', '').split(':');
    final initialHour = int.tryParse(parts[0]) ?? 6;
    final initialMinute =
        parts.length > 1 ? (int.tryParse(parts[1]) ?? 15) : 15;

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initialHour, minute: initialMinute),
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
      final hourStr = picked.hour.toString().padLeft(2, '0');
      final minStr = picked.minute.toString().padLeft(2, '0');
      final formattedTime = '$hourStr:$minStr WIB';

      // Schedule masuk is 05:00
      final arrivalMinutes = picked.hour * 60 + picked.minute;
      const scheduleMinutes = 5 * 60;
      final diff = arrivalMinutes - scheduleMinutes;
      final menitTerlambat = diff > 0 ? diff : 0;

      if (context.mounted) {
        context.read<IzinDaruratBloc>().add(
              ChangeIzinDaruratTimeEvent(
                jamTiba: formattedTime,
                menitTerlambat: menitTerlambat,
              ),
            );
      }
    }
  }

  void _showKategoriPicker(BuildContext context, String currentKategori) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.selectEmergencyCategory,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 16),
                ..._kategoriList.map((kat) {
                  final isSelected = kat == currentKategori;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    title: Text(
                      kat,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF2563EB)
                            : const Color(0xFF0F172A),
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF2563EB),
                          )
                        : null,
                    onTap: () {
                      context
                          .read<IzinDaruratBloc>()
                          .add(ChangeIzinDaruratKategoriEvent(kat));
                      Navigator.pop(sheetContext);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<IzinDaruratBloc, IzinDaruratState>(
      listener: (context, state) {
        if (state is IzinDaruratLoaded) {
          if (_alasanController.text != state.data.alasan) {
            _alasanController.text = state.data.alasan;
          }

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
                    child: Text(l10n.tryAgain),
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
                      Text(
                        l10n.emergencyLeaveTerms,
                        style: const TextStyle(
                          fontSize: 14.5,
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
                        child: Text(
                          l10n.noQuotaDeduction,
                          style: const TextStyle(
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
                      border: Border.all(color: const Color(0xFFDBEAFE)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 17,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.emergencyLeavePolicyDesc,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF475569),
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

            // 2. Jenis & Waktu Darurat Card
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
                  Text(
                    l10n.emergencyTypeAndTime,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Sub-tabs Segmented Switcher
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildSubTabItem(
                            label: 'Tidak Masuk (Full)',
                            isSelected:
                                data.jenis == IzinDaruratJenis.tidakMasuk,
                            onTap: () {
                              context.read<IzinDaruratBloc>().add(
                                    const ChangeIzinDaruratJenisEvent(
                                      IzinDaruratJenis.tidakMasuk,
                                    ),
                                  );
                            },
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: _buildSubTabItem(
                            label: 'Izin Terlambat',
                            isSelected:
                                data.jenis == IzinDaruratJenis.terlambat,
                            onTap: () {
                              context.read<IzinDaruratBloc>().add(
                                    const ChangeIzinDaruratJenisEvent(
                                      IzinDaruratJenis.terlambat,
                                    ),
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // If Tidak Masuk (Full)
                  if (data.jenis == IzinDaruratJenis.tidakMasuk) ...[
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateItem(
                            label: 'Tanggal Mulai',
                            dateText: _formatDate(data.startDate),
                            icon: Icons.calendar_today_outlined,
                            onTap: () => _selectDate(
                              context,
                              initialDate: data.startDate,
                              firstDate: DateTime(2026, 1, 1),
                              onSelected: (date) {
                                final newEnd = date.isAfter(data.endDate)
                                    ? date
                                    : data.endDate;
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
                            icon: Icons.calendar_today_outlined,
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
                          Text(
                            '• Durasi: ${data.durationDays} Hari Kerja',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1D4ED8),
                            ),
                          ),
                          Text(
                            'Kuota Cuti: Tetap ${data.kuotaCuti} Hari',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // If Izin Terlambat
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateItem(
                            label: 'Tanggal Shift',
                            dateText: _formatDate(data.startDate),
                            icon: Icons.calendar_today_outlined,
                            onTap: () => _selectDate(
                              context,
                              initialDate: data.startDate,
                              firstDate: DateTime(2026, 1, 1),
                              onSelected: (date) {
                                context.read<IzinDaruratBloc>().add(
                                      ChangeIzinDaruratDateRangeEvent(
                                        startDate: date,
                                        endDate: date,
                                      ),
                                    );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildDateItem(
                            label: 'Estimasi Jam Tiba',
                            dateText: data.jamTiba,
                            icon: Icons.access_time_rounded,
                            iconColor: const Color(0xFF2563EB),
                            onTap: () => _selectTime(context, data),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jadwal Masuk: ${data.jadwalMasuk}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              Text(
                                '• Izin Terlambat: ${data.menitTerlambat} Menit',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1D4ED8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Estimasi tiba pukul ${data.jamTiba.replaceAll(' WIB', '')} WIB (terlambat ${_formatTerlambatDuration(data.menitTerlambat)}).\nWajib scan wajah saat tiba di dapur.',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. Kategori, Keterangan & Lampiran Card (Unified Card)
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
                  // Kategori Kondisi Darurat
                  const Text(
                    'Kategori Kondisi Darurat',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => _showKategoriPicker(context, data.kategori),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Text(
                        data.kategori,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Contoh: Keluarga rawat darurat, kendaraan mogok, banjir/bencana, dll.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Keterangan Singkat
                  const Text(
                    'Keterangan Singkat',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _alasanController,
                          maxLines: 3,
                          minLines: 2,
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

                  // Lampirkan Bukti
                  const Text(
                    'Lampirkan Bukti',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (data.attachmentName == null) ...[
                    InkWell(
                      onTap: () {
                        context.read<IzinDaruratBloc>().add(
                              const ChangeIzinDaruratAttachmentEvent(
                                'foto_kondisi_darurat.jpg',
                              ),
                            );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: CustomPaint(
                        painter: const DashedBorderPainter(
                          color: Color(0xFF93C5FD),
                          radius: 12,
                          strokeWidth: 1.2,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBFDFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEFF6FF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.photo_camera_outlined,
                                  color: Color(0xFF2563EB),
                                  size: 22,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Unggah foto kondisi di tempat, surat IGD, atau\ntangkapan layar (JPG, PNG, PDF • Maks. 2MB)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF64748B),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF93C5FD)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF16A34A),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              data.attachmentName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<IzinDaruratBloc>().add(
                                    const ChangeIzinDaruratAttachmentEvent(
                                      null,
                                    ),
                                  );
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: Color(0xFF64748B),
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Notice Footer
            const Center(
              child: Text(
                'Akan diteruskan sebagai prioritas ke Koordinator Unit SPPG\nRawamangun 01.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF475569),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 14),

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
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
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
                            Colors.white,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.jenis == IzinDaruratJenis.terlambat
                                ? 'Kirim Izin Terlambat'
                                : 'Kirim Izin Darurat',
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded, size: 16),
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

  Widget _buildSubTabItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: const Color(0xFF93C5FD), width: 1.2)
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected
                  ? const Color(0xFF0F172A)
                  : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateItem({
    required String label,
    required String dateText,
    required IconData icon,
    Color? iconColor,
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
                Icon(
                  icon,
                  size: 15,
                  color: iconColor ?? const Color(0xFF64748B),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;
  final double dashWidth;
  final double dashSpace;

  const DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.2,
    this.radius = 12.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final len = (distance + dashWidth < metric.length)
            ? dashWidth
            : metric.length - distance;
        final extractPath = metric.extractPath(distance, distance + len);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      radius != oldDelegate.radius;
}
