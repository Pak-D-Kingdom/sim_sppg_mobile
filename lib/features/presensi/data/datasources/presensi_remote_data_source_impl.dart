import 'package:sim_sppg_mobile/core/network/dio_client.dart';
import '../../domain/entities/presensi_data.dart';
import '../models/presensi_data_model.dart';
import 'presensi_remote_data_source.dart';

class PresensiRemoteDataSourceImpl implements PresensiRemoteDataSource {
  final DioClient dioClient;

  // Cache state simulasi
  bool _isClockedIn = false;
  String _clockInTime = '04:52 WIB';

  PresensiRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<PresensiDataModel> getPresensiStatus({PresensiType? requestedType}) async {
    // Jika type diminta secara eksplisit, gunakan type tersebut
    final PresensiType type = requestedType ??
        (_isClockedIn ? PresensiType.clockOut : PresensiType.clockIn);

    if (type == PresensiType.clockIn) {
      return const PresensiDataModel(
        type: PresensiType.clockIn,
        locationTitle: 'Lokasi Dapur Terverifikasi',
        locationDistance: '18m dari titik SPPG Rawamangun 01',
        isInRadius: true,
        deadlineText: 'Wajib absen sebelum 05:00 WIB',
        remainingTimeBadge: 'Sisa 8 menit',
        isFaceDetected: true,
        isLivenessOk: true,
      );
    } else {
      return PresensiDataModel(
        type: PresensiType.clockOut,
        locationTitle: 'Lokasi Dapur Terverifikasi',
        locationDistance: '18m dari titik SPPG Rawamangun 01',
        isInRadius: true,
        clockInTime: _clockInTime,
        clockInStatus: 'Tepat Waktu',
        workDuration: '8 Jam 10 Menit',
        deadlineText: 'Jadwal pulang telah tiba (Mulai 13:00 WIB)',
        remainingTimeBadge: '',
        isFaceDetected: true,
        isLivenessOk: true,
      );
    }
  }

  @override
  Future<PresensiDataModel> submitClockIn({
    required String photoPath,
    required double latitude,
    required double longitude,
  }) async {
    _isClockedIn = true;
    _clockInTime = '04:52 WIB';

    return PresensiDataModel(
      type: PresensiType.clockOut, // Setelah clock-in, berikutnya clock-out
      locationTitle: 'Lokasi Dapur Terverifikasi',
      locationDistance: '18m dari titik SPPG Rawamangun 01',
      isInRadius: true,
      clockInTime: _clockInTime,
      clockInStatus: 'Tepat Waktu',
      workDuration: '8 Jam 10 Menit',
      deadlineText: 'Jadwal pulang telah tiba (Mulai 13:00 WIB)',
      remainingTimeBadge: '',
      isFaceDetected: true,
      isLivenessOk: true,
    );
  }

  @override
  Future<PresensiDataModel> submitClockOut({
    required String photoPath,
    required double latitude,
    required double longitude,
  }) async {
    _isClockedIn = false;

    return PresensiDataModel(
      type: PresensiType.clockIn,
      locationTitle: 'Lokasi Dapur Terverifikasi',
      locationDistance: '18m dari titik SPPG Rawamangun 01',
      isInRadius: true,
      clockInTime: '04:52 WIB',
      clockInStatus: 'Tepat Waktu',
      workDuration: '8 Jam 10 Menit',
      deadlineText: 'Presensi harian telah selesai',
      remainingTimeBadge: '',
      isFaceDetected: true,
      isLivenessOk: true,
    );
  }
}
