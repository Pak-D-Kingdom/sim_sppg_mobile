import '../models/riwayat_absen_model.dart';

abstract class RiwayatAbsenRemoteDataSource {
  Future<RiwayatAbsenDataModel> getRiwayatAbsen({
    required int month,
    required int year,
  });
}
