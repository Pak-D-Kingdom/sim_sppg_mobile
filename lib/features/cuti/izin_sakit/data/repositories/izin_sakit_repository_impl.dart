import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/izin_sakit_entity.dart';
import '../../domain/repositories/izin_sakit_repository.dart';
import '../datasources/izin_sakit_remote_data_source.dart';

class IzinSakitRepositoryImpl implements IzinSakitRepository {
  final IzinSakitRemoteDataSource remoteDataSource;

  IzinSakitRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, IzinSakitData>> getActiveIzinSakit() async {
    try {
      final result = await remoteDataSource.getActiveIzinSakit();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, IzinSakitData>> submitLaporanAwalSakit({
    required DateTime startDate,
    required DateTime endDate,
    required int durationDays,
    required String keluhan,
  }) async {
    try {
      final result = await remoteDataSource.submitLaporanAwalSakit(
        startDate: startDate,
        endDate: endDate,
        durationDays: durationDays,
        keluhan: keluhan,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, IzinSakitData>> submitBuktiSakit({
    required String attachmentName,
  }) async {
    try {
      final result = await remoteDataSource.submitBuktiSakit(
        attachmentName: attachmentName,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
