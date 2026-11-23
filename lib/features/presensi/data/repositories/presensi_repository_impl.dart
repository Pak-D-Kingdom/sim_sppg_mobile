import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/presensi_data.dart';
import '../../domain/repositories/presensi_repository.dart';
import '../datasources/presensi_remote_data_source.dart';

class PresensiRepositoryImpl implements PresensiRepository {
  final PresensiRemoteDataSource remoteDataSource;

  PresensiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PresensiData>> getPresensiStatus({
    PresensiType? requestedType,
  }) async {
    try {
      final res = await remoteDataSource.getPresensiStatus(
        requestedType: requestedType,
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PresensiData>> submitClockIn({
    required String photoPath,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final res = await remoteDataSource.submitClockIn(
        photoPath: photoPath,
        latitude: latitude,
        longitude: longitude,
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PresensiData>> submitClockOut({
    required String photoPath,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final res = await remoteDataSource.submitClockOut(
        photoPath: photoPath,
        latitude: latitude,
        longitude: longitude,
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
