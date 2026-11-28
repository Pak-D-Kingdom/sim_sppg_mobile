import 'dart:io';

import 'package:camera/camera.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations_extension.dart';

class PresensiCameraViewfinderWidget extends StatefulWidget {
  final bool isActive;
  final bool isFaceDetected;
  final bool isLivenessOk;
  final String? capturedPhotoPath;
  final ValueChanged<String?>? onPhotoCaptured;

  const PresensiCameraViewfinderWidget({
    super.key,
    this.isActive = true,
    this.isFaceDetected = true,
    this.isLivenessOk = true,
    this.capturedPhotoPath,
    this.onPhotoCaptured,
  });

  @override
  State<PresensiCameraViewfinderWidget> createState() =>
      _PresensiCameraViewfinderWidgetState();
}

class _PresensiCameraViewfinderWidgetState
    extends State<PresensiCameraViewfinderWidget>
    with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;
  bool _isCameraInitialized = false;
  bool _isInitializingCamera = false;
  bool _isCapturing = false;

  late final AnimationController _scanAnimationController;
  late final Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();

    _scanAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _scanAnimation = Tween<double>(begin: 0.20, end: 0.88).animate(
      CurvedAnimation(
        parent: _scanAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant PresensiCameraViewfinderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isActive && oldWidget.isActive) {
      _stopCamera();
    }
  }

  Future<void> _startCamera() async {
    if (_isInitializingCamera || _isCameraInitialized) return;

    setState(() {
      _isInitializingCamera = true;
    });

    CameraController? controller;
    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        if (mounted) {
          _showSnackBar(context.l10n.cameraUnavailable);
        }
        return;
      }

      final frontCameraIndex = _cameras!.indexWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
      );
      _selectedCameraIndex = frontCameraIndex != -1 ? frontCameraIndex : 0;

      controller = CameraController(
        _cameras![_selectedCameraIndex],
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller.initialize();

      if (!mounted || !widget.isActive) {
        await controller.dispose();
        return;
      }

      _cameraController = controller;
      _scanAnimationController.repeat(reverse: true);
      setState(() {
        _isCameraInitialized = true;
      });
    } on CameraException catch (e) {
      await controller?.dispose();
      if (mounted) {
        final code = e.code.toLowerCase();
        final isPermissionError =
            code.contains('access') || code.contains('permission');
        _showSnackBar(
          isPermissionError
              ? context.l10n.cameraPermissionDenied
              : context.l10n.cameraUnavailable,
        );
      }
    } catch (_) {
      await controller?.dispose();
      if (mounted) {
        _showSnackBar(context.l10n.cameraUnavailable);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isInitializingCamera = false;
        });
      }
    }
  }

  Future<void> _stopCamera() async {
    _scanAnimationController.stop();
    final oldController = _cameraController;
    _cameraController = null;
    if (mounted) {
      setState(() {
        _isCameraInitialized = false;
        _isInitializingCamera = false;
      });
    }
    await oldController?.dispose();
  }

  Future<void> _capturePhoto() async {
    if (_isCapturing ||
        !_isCameraInitialized ||
        _cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return;
    }

    setState(() {
      _isCapturing = true;
    });

    try {
      final file = await _cameraController!.takePicture();
      await _stopCamera();
      if (mounted) {
        widget.onPhotoCaptured?.call(file.path);
      }
    } catch (_) {
      if (mounted) {
        _showSnackBar(context.l10n.cameraUnavailable);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCapturing = false;
        });
      }
    }
  }

  Future<void> _retakePhoto() async {
    widget.onPhotoCaptured?.call(null);
    await _startCamera();
  }

  Future<void> _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) {
      _showSnackBar(context.l10n.singleCameraNotice);
      return;
    }

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
    final oldController = _cameraController;
    setState(() {
      _isCameraInitialized = false;
      _cameraController = null;
    });
    await oldController?.dispose();

    final newController = CameraController(
      _cameras![_selectedCameraIndex],
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _cameraController = newController;

    try {
      await newController.initialize();
      if (mounted && _cameraController == newController) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (_) {
      await newController.dispose();
      if (_cameraController == newController) {
        _cameraController = null;
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasCapturedPhoto = widget.capturedPhotoPath != null &&
        widget.capturedPhotoPath!.isNotEmpty;
    final isLiveCamera = !hasCapturedPhoto &&
        _isCameraInitialized &&
        _cameraController != null &&
        _cameraController!.value.isInitialized;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Viewfinder Container (Persegi 1:1 dengan crop proporsional)
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF0F172A),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // 1. Captured Photo / Live Camera / Idle Background
                    if (hasCapturedPhoto)
                      File(widget.capturedPhotoPath!).existsSync()
                          ? Image.file(
                              File(widget.capturedPhotoPath!),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  _buildSimulatedCameraBackground(),
                            )
                          : _buildSimulatedCameraBackground()
                    else if (isLiveCamera)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return FittedBox(
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                            child: SizedBox(
                              width: constraints.maxWidth,
                              child: CameraPreview(_cameraController!),
                            ),
                          );
                        },
                      )
                    else
                      _buildSimulatedCameraBackground(),

                    // 2. Animated Laser Scan Bar (hanya saat kamera aktif)
                    if (isLiveCamera)
                      AnimatedBuilder(
                        animation: _scanAnimation,
                        builder: (context, child) {
                          return Align(
                            alignment:
                                Alignment(0, (_scanAnimation.value * 2) - 1),
                            child: Container(
                              width: double.infinity,
                              height: 2,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF60A5FA)
                                        .withValues(alpha: 0.8),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Color(0xFF93C5FD),
                                    Color(0xFF60A5FA),
                                    Color(0xFF93C5FD),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                    // 3. Four Corner Brackets (┌ ┐ └ ┘)
                    if (!hasCapturedPhoto)
                      Positioned.fill(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(26.0, 56.0, 26.0, 26.0),
                          child: CustomPaint(
                            painter: _ViewfinderCornersPainter(),
                          ),
                        ),
                      ),

                    // Loading saat menyalakan kamera
                    if (_isInitializingCamera)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF93C5FD),
                        ),
                      ),

                    // 4. Camera Controls (hanya saat kamera aktif)
                    if (isLiveCamera) ...[
                      Positioned(
                        top: 10,
                        left: 10,
                        child: _buildCameraIconButton(
                          icon: Icons.flip_camera_ios_rounded,
                          onTap: _switchCamera,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: _buildCameraIconButton(
                          icon: Icons.close_rounded,
                          onTap: _stopCamera,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Teks Instruksi Bawah
          Text(
            hasCapturedPhoto
                ? context.l10n.photoCapturedInstruction
                : isLiveCamera
                    ? context.l10n.faceFrameInstruction
                    : context.l10n.cameraOffInstruction,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),

          // Step Action Button: Hidupkan Kamera -> Capture -> Foto Ulang
          SizedBox(
            width: double.infinity,
            height: 46,
            child: hasCapturedPhoto
                ? OutlinedButton.icon(
                    onPressed: _retakePhoto,
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: Text(
                      context.l10n.retakePhoto,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.onSurface,
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  )
                : isLiveCamera
                    ? ElevatedButton.icon(
                        onPressed: _isCapturing ? null : _capturePhoto,
                        icon: _isCapturing
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.camera_alt_rounded, size: 18),
                        label: Text(
                          context.l10n.capturePhoto,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: _isInitializingCamera ? null : _startCamera,
                        icon: const Icon(Icons.videocam_rounded, size: 19),
                        label: Text(
                          context.l10n.turnOnCamera,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F172A),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSimulatedCameraBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.9,
          colors: [
            Color(0xFF1E293B),
            Color(0xFF0F172A),
            Color(0xFF020617),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.18,
            child: Icon(
              Icons.face_retouching_natural_rounded,
              size: 110,
              color: const Color(0xFF93C5FD),
            ),
          ),
          Opacity(
            opacity: 0.08,
            child: GridPaper(
              color: const Color(0xFF60A5FA),
              divisions: 2,
              subdivisions: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// CustomPainter untuk menggambar 4 sudut bingkai (┌ ┐ └ ┘)
class _ViewfinderCornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF93C5FD)
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const cornerLength = 26.0;

    // Top-Left (┌)
    canvas.drawLine(const Offset(0, 0), const Offset(cornerLength, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, cornerLength), paint);

    // Top-Right (┐)
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width - cornerLength, 0), paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, cornerLength), paint);

    // Bottom-Left (└)
    canvas.drawLine(
        Offset(0, size.height), Offset(cornerLength, size.height), paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - cornerLength), paint);

    // Bottom-Right (┘)
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - cornerLength, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - cornerLength), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
