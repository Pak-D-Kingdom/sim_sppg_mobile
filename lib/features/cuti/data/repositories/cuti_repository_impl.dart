import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/cuti_form_data.dart';
import '../../domain/entities/cuti_quota.dart';
import '../../domain/repositories/cuti_repository.dart';
import '../datasources/cuti_remote_data_source.dart';

class CutiRepositoryImpl implements CutiRepository {
  final CutiRemoteDataSource remoteDataSource;

  CutiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CutiQuota>> getCutiQuota() async {
    try {
      final quota = await remoteDataSource.getCutiQuota();
      return Right(quota);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> submitCuti(CutiFormData formData) async {
    try {
      final message = await remoteDataSource.submitCuti(formData);
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
