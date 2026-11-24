import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/akun_profile.dart';
import '../repositories/akun_repository.dart';

class GetAkunProfile {
  final AkunRepository repository;

  GetAkunProfile(this.repository);

  Future<Either<Failure, AkunProfile>> call() {
    return repository.getAkunProfile();
  }
}
