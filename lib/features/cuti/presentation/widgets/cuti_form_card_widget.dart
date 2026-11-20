import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/cuti_type.dart';

class CutiFormCardWidget extends StatefulWidget {
  final String initialReason;
  final String? attachmentName;
  final CutiType cutiType;
  final ValueChanged<String> onReasonChanged;
  final ValueChanged<String?> onAttachmentChanged;

  const CutiFormCardWidget({
    super.key,
    required this.initialReason,
    this.attachmentName,
    required this.cutiType,
    required this.onReasonChanged,
    required this.onAttachmentChanged,
  });

  @override
  State<CutiFormCardWidget> createState() => _CutiFormCardWidgetState();
}

class _CutiFormCardWidgetState extends State<CutiFormCardWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialReason);
  }

  @override
  void didUpdateWidget(covariant CutiFormCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialReason != widget.initialReason &&
        _controller.text != widget.initialReason) {
      _controller.text = widget.initialReason;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _simulatePickFile() {
    // Simulate attaching a document based on type
    final sampleFile = widget.cutiType == CutiType.izinSakit
        ? 'surat_keterangan_dokter_rs.pdf'
        : 'lampiran_surat_keluarga.pdf';
    widget.onAttachmentChanged(sampleFile);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('File "$sampleFile" berhasil dilampirkan.'),
        backgroundColor: const Color(0xFF16A34A),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // 1. Alasan / Keterangan
          const Text(
            'Alasan / Keterangan',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 10),

          // Text Field with Character Counter
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
                  controller: _controller,
                  maxLines: 4,
                  maxLength: 200,
                  buildCounter: (
                    _, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) =>
                      null, // Hide default counter to render custom
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
                    hintText: 'Tuliskan alasan pengajuan cuti secara singkat...',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  onChanged: (text) {
                    setState(() {});
                    widget.onReasonChanged(text);
                  },
                ),
                Text(
                  '${_controller.text.length}/200',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 2. Lampirkan Bukti
          const Text(
            'Lampirkan Bukti',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 10),

          // Upload Area Box
          if (widget.attachmentName != null) ...[
            // Attached state
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF93C5FD), width: 1.2),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.attachmentName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Tersimpan • 1.2 MB',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 18),
                    color: AppColors.textSecondary,
                    onPressed: () => widget.onAttachmentChanged(null),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Empty Upload Box matching the design
            GestureDetector(
              onTap: _simulatePickFile,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF93C5FD),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.file_upload_outlined,
                      size: 26,
                      color: Color(0xFF2563EB),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.cutiType.attachmentHint,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
