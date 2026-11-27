import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class GetCachedSession implements UseCase<AuthSession?, NoParams> {
  final AuthRepository repository;

  GetCachedSession(this.repository);

  @override
  Future<Either<Failure, AuthSession?>> call(NoParams params) {
    return repository.getCachedSession();
  }
}
