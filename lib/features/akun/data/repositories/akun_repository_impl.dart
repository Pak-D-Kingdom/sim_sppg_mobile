import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/akun_profile.dart';
import '../../domain/repositories/akun_repository.dart';
import '../datasources/akun_remote_data_source.dart';

class AkunRepositoryImpl implements AkunRepository {
  final AkunRemoteDataSource remoteDataSource;

  AkunRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AkunProfile>> getAkunProfile() async {
    try {
      final result = await remoteDataSource.getAkunProfile();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
