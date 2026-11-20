import '../models/jadwal_data_model.dart';

abstract class JadwalRemoteDataSource {
  Future<JadwalDataModel> getJadwal({int? month, int? year});
}
