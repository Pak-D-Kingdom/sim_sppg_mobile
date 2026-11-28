import 'package:equatable/equatable.dart';

enum PresensiType {
  clockIn, // Gambar 1: Presensi Kehadiran
  clockOut, // Gambar 2: Presensi Pulang
}

class PresensiData extends Equatable {
  final PresensiType type;
  final String locationTitle;
  final String locationDistance;
  final bool isInRadius;
  final String clockInTime;
  final String clockInStatus;
  final String workDuration;
  final String deadlineText;
  final String remainingTimeBadge;
  final bool isFaceDetected;
  final bool isLivenessOk;
  final String? capturedPhotoPath;

  const PresensiData({
    required this.type,
    this.locationTitle = 'Lokasi Dapur Terverifikasi',
    this.locationDistance = '18m dari titik SPPG Rawamangun 01',
    this.isInRadius = true,
    this.clockInTime = '04:52 WIB',
    this.clockInStatus = 'Tepat Waktu',
    this.workDuration = '8 Jam 10 Menit',
    this.deadlineText = 'Wajib absen sebelum 05:00 WIB',
    this.remainingTimeBadge = 'Sisa 8 menit',
    this.isFaceDetected = true,
    this.isLivenessOk = true,
    this.capturedPhotoPath,
  });

  PresensiData copyWith({
    PresensiType? type,
    String? locationTitle,
    String? locationDistance,
    bool? isInRadius,
    String? clockInTime,
    String? clockInStatus,
    String? workDuration,
    String? deadlineText,
    String? remainingTimeBadge,
    bool? isFaceDetected,
    bool? isLivenessOk,
    String? capturedPhotoPath,
    bool clearCapturedPhoto = false,
  }) {
    return PresensiData(
      type: type ?? this.type,
      locationTitle: locationTitle ?? this.locationTitle,
      locationDistance: locationDistance ?? this.locationDistance,
      isInRadius: isInRadius ?? this.isInRadius,
      clockInTime: clockInTime ?? this.clockInTime,
      clockInStatus: clockInStatus ?? this.clockInStatus,
      workDuration: workDuration ?? this.workDuration,
      deadlineText: deadlineText ?? this.deadlineText,
      remainingTimeBadge: remainingTimeBadge ?? this.remainingTimeBadge,
      isFaceDetected: isFaceDetected ?? this.isFaceDetected,
      isLivenessOk: isLivenessOk ?? this.isLivenessOk,
      capturedPhotoPath: clearCapturedPhoto
          ? null
          : (capturedPhotoPath ?? this.capturedPhotoPath),
    );
  }

  @override
  List<Object?> get props => [
        type,
        locationTitle,
        locationDistance,
        isInRadius,
        clockInTime,
        clockInStatus,
        workDuration,
        deadlineText,
        remainingTimeBadge,
        isFaceDetected,
        isLivenessOk,
        capturedPhotoPath,
      ];
}
