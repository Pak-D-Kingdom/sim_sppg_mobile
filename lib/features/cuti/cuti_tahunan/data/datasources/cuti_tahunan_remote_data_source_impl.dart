import 'package:sim_sppg_mobile/core/network/dio_client.dart';
import '../../domain/entities/cuti_tahunan_entity.dart';
import '../models/cuti_tahunan_model.dart';
import 'cuti_tahunan_remote_data_source.dart';

class CutiTahunanRemoteDataSourceImpl implements CutiTahunanRemoteDataSource {
  final DioClient dioClient;

  CutiTahunanRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<CutiTahunanQuotaModel> getQuota() async {
    return const CutiTahunanQuotaModel(
      totalQuota: 12,
      usedQuota: 7,
      remainingQuota: 5,
    );
  }

  @override
  Future<String> submitCuti(CutiTahunanFormData formData) async {
    return 'Pengajuan Cuti Tahunan berhasil diteruskan ke Koordinator Unit.';
  }
}
