import '../../domain/entities/cuti_tahunan_entity.dart';
import '../models/cuti_tahunan_model.dart';

abstract class CutiTahunanRemoteDataSource {
  Future<CutiTahunanQuotaModel> getQuota();
  Future<String> submitCuti(CutiTahunanFormData formData);
}
