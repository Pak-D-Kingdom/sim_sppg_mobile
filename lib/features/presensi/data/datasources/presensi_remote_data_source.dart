import '../../domain/entities/presensi_data.dart';
import '../models/presensi_data_model.dart';

abstract class PresensiRemoteDataSource {
  Future<PresensiDataModel> getPresensiStatus({PresensiType? requestedType});
  Future<PresensiDataModel> submitClockIn({
    required String photoPath,
    required double latitude,
    required double longitude,
  });
  Future<PresensiDataModel> submitClockOut({
    required String photoPath,
    required double latitude,
    required double longitude,
  });
}
