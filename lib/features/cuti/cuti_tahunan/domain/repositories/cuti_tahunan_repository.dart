import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/cuti_tahunan_entity.dart';

abstract class CutiTahunanRepository {
  Future<Either<Failure, CutiTahunanQuota>> getQuota();
  Future<Either<Failure, String>> submitCuti(CutiTahunanFormData formData);
}
