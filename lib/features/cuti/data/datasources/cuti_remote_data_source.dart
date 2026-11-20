import '../../domain/entities/cuti_form_data.dart';
import '../models/cuti_quota_model.dart';

abstract class CutiRemoteDataSource {
  Future<CutiQuotaModel> getCutiQuota();
  Future<String> submitCuti(CutiFormData formData);
}
