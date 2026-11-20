import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/cuti_tahunan_entity.dart';
import '../repositories/cuti_tahunan_repository.dart';

class GetCutiTahunanQuota {
  final CutiTahunanRepository repository;

  GetCutiTahunanQuota(this.repository);

  Future<Either<Failure, CutiTahunanQuota>> call() async {
    return await repository.getQuota();
  }
}

class SubmitCutiTahunan {
  final CutiTahunanRepository repository;

  SubmitCutiTahunan(this.repository);

  Future<Either<Failure, String>> call(CutiTahunanFormData formData) async {
    return await repository.submitCuti(formData);
  }
}
