import '../../domain/entities/presensi_data.dart';

class PresensiDataModel extends PresensiData {
  const PresensiDataModel({
    required super.type,
    super.locationTitle = 'Lokasi Dapur Terverifikasi',
    super.locationDistance = '18m dari titik SPPG Rawamangun 01',
    super.isInRadius = true,
    super.clockInTime = '04:52 WIB',
    super.clockInStatus = 'Tepat Waktu',
    super.workDuration = '8 Jam 10 Menit',
    super.deadlineText = 'Wajib absen sebelum 05:00 WIB',
    super.remainingTimeBadge = 'Sisa 8 menit',
    super.isFaceDetected = true,
    super.isLivenessOk = true,
    super.capturedPhotoPath,
  });

  factory PresensiDataModel.fromJson(Map<String, dynamic> json) {
    return PresensiDataModel(
      type: json['type'] == 'clock_out'
          ? PresensiType.clockOut
          : PresensiType.clockIn,
      locationTitle: json['location_title'] ?? 'Lokasi Dapur Terverifikasi',
      locationDistance:
          json['location_distance'] ?? '18m dari titik SPPG Rawamangun 01',
      isInRadius: json['is_in_radius'] ?? true,
      clockInTime: json['clock_in_time'] ?? '04:52 WIB',
      clockInStatus: json['clock_in_status'] ?? 'Tepat Waktu',
      workDuration: json['work_duration'] ?? '8 Jam 10 Menit',
      deadlineText: json['deadline_text'] ?? 'Wajib absen sebelum 05:00 WIB',
      remainingTimeBadge: json['remaining_time_badge'] ?? 'Sisa 8 menit',
      isFaceDetected: json['is_face_detected'] ?? true,
      isLivenessOk: json['is_liveness_ok'] ?? true,
      capturedPhotoPath: json['captured_photo_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type == PresensiType.clockOut ? 'clock_out' : 'clock_in',
      'location_title': locationTitle,
      'location_distance': locationDistance,
      'is_in_radius': isInRadius,
      'clock_in_time': clockInTime,
      'clock_in_status': clockInStatus,
      'work_duration': workDuration,
      'deadline_text': deadlineText,
      'remaining_time_badge': remainingTimeBadge,
      'is_face_detected': isFaceDetected,
      'is_liveness_ok': isLivenessOk,
      if (capturedPhotoPath != null) 'captured_photo_path': capturedPhotoPath,
    };
  }
}
