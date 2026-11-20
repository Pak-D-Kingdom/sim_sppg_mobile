import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cuti_form_data.dart';
import '../entities/cuti_quota.dart';

abstract class CutiRepository {
  Future<Either<Failure, CutiQuota>> getCutiQuota();
  Future<Either<Failure, String>> submitCuti(CutiFormData formData);
}
