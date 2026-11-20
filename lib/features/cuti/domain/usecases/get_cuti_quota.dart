import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/cuti_quota.dart';
import '../repositories/cuti_repository.dart';

class GetCutiQuota implements UseCase<CutiQuota, NoParams> {
  final CutiRepository repository;

  GetCutiQuota(this.repository);

  @override
  Future<Either<Failure, CutiQuota>> call(NoParams params) async {
    return await repository.getCutiQuota();
  }
}
