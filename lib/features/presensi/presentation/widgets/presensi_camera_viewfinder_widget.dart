import 'package:camera/camera.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../core/constants/app_colors.dart';

class PresensiCameraViewfinderWidget extends StatefulWidget {
  final bool isFaceDetected;
  final bool isLivenessOk;
  final VoidCallback? onPhotoCaptured;

  const PresensiCameraViewfinderWidget({
    super.key,
    this.isFaceDetected = true,
    this.isLivenessOk = true,
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

  late final AnimationController _scanAnimationController;
  late final Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();

    // Laser scan animation
    _scanAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0.20, end: 0.88).animate(
      CurvedAnimation(
        parent: _scanAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _initializeRealCamera();
  }

  Future<void> _initializeRealCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        // Cari kamera depan terlebih dahulu
        int frontCameraIndex = _cameras!.indexWhere(
          (c) => c.lensDirection == CameraLensDirection.front,
        );
        _selectedCameraIndex =
            frontCameraIndex != -1 ? frontCameraIndex : 0;

        _cameraController = CameraController(
          _cameras![_selectedCameraIndex],
          ResolutionPreset.medium,
          enableAudio: false,
        );

        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (_) {
      // Fallback mulus untuk environment tanpa hardware camera (misal desktop linux)
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hanya 1 kamera tersedia atau menggunakan simulasi.'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
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
    } catch (_) {}
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Color(0xFF0F172A), // Dark slate navy
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // 1. Live Camera Stream (center-crop agar tidak gepeng) atau Simulated Background
                    if (_isCameraInitialized &&
                        _cameraController != null &&
                        _cameraController!.value.isInitialized)
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

                    // 2. Animated Laser Scan Bar
                    AnimatedBuilder(
                      animation: _scanAnimation,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment(0, (_scanAnimation.value * 2) - 1),
                          child: Container(
                            width: double.infinity,
                            height: 2,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF60A5FA).withValues(alpha: 0.8),
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
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(26.0, 56.0, 26.0, 26.0),
                        child: CustomPaint(
                          painter: _ViewfinderCornersPainter(),
                        ),
                      ),
                    ),

                    // 4. Camera Switch Button (Pojok Kiri Atas)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: InkWell(
                        onTap: _switchCamera,
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
                          child: const Center(
                            child: Icon(
                              Icons.flip_camera_ios_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Teks Instruksi Bawah
          const Text(
            'Pastikan wajah terlihat jelas di dalam bingkai tanpa masker',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
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
          // Silhouette Wajah / Face Mesh Hint
          Opacity(
            opacity: 0.18,
            child: Icon(
              Icons.face_retouching_natural_rounded,
              size: 110,
              color: const Color(0xFF93C5FD),
            ),
          ),
          // Subtle grid pattern lines
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
