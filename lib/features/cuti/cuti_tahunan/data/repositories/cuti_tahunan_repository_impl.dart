import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/cuti_tahunan_entity.dart';
import '../../domain/repositories/cuti_tahunan_repository.dart';
import '../datasources/cuti_tahunan_remote_data_source.dart';

class CutiTahunanRepositoryImpl implements CutiTahunanRepository {
  final CutiTahunanRemoteDataSource remoteDataSource;

  CutiTahunanRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CutiTahunanQuota>> getQuota() async {
    try {
      final result = await remoteDataSource.getQuota();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> submitCuti(CutiTahunanFormData formData) async {
    try {
      final result = await remoteDataSource.submitCuti(formData);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
