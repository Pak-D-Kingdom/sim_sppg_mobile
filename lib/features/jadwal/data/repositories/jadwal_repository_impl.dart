import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/jadwal_data.dart';
import '../../domain/repositories/jadwal_repository.dart';
import '../datasources/jadwal_remote_data_source.dart';

class JadwalRepositoryImpl implements JadwalRepository {
  final JadwalRemoteDataSource remoteDataSource;

  JadwalRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, JadwalData>> getJadwal({int? month, int? year}) async {
    try {
      final result = await remoteDataSource.getJadwal(month: month, year: year);
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
