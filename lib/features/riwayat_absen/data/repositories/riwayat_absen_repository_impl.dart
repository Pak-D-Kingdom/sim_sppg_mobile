import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/riwayat_absen_data.dart';
import '../../domain/repositories/riwayat_absen_repository.dart';
import '../datasources/riwayat_absen_remote_data_source.dart';

class RiwayatAbsenRepositoryImpl implements RiwayatAbsenRepository {
  final RiwayatAbsenRemoteDataSource remoteDataSource;

  RiwayatAbsenRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, RiwayatAbsenData>> getRiwayatAbsen({
    required int month,
    required int year,
  }) async {
    try {
      final result = await remoteDataSource.getRiwayatAbsen(
        month: month,
        year: year,
      );
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
