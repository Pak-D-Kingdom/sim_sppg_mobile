import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/izin_darurat_entity.dart';
import '../../domain/repositories/izin_darurat_repository.dart';
import '../datasources/izin_darurat_remote_data_source.dart';

class IzinDaruratRepositoryImpl implements IzinDaruratRepository {
  final IzinDaruratRemoteDataSource remoteDataSource;

  IzinDaruratRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, IzinDaruratData>> getInitialData() async {
    try {
      final res = await remoteDataSource.getInitialData();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, IzinDaruratData>> submitIzinDarurat({
    required DateTime startDate,
    required DateTime endDate,
    required int durationDays,
    required String kategori,
    required String alasan,
    String? attachmentName,
  }) async {
    try {
      final res = await remoteDataSource.submitIzinDarurat(
        startDate: startDate,
        endDate: endDate,
        durationDays: durationDays,
        kategori: kategori,
        alasan: alasan,
        attachmentName: attachmentName,
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
