import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/presensi_data.dart';

abstract class PresensiRepository {
  Future<Either<Failure, PresensiData>> getPresensiStatus({PresensiType? requestedType});
  Future<Either<Failure, PresensiData>> submitClockIn({
    required String photoPath,
    required double latitude,
    required double longitude,
  });
  Future<Either<Failure, PresensiData>> submitClockOut({
    required String photoPath,
    required double latitude,
    required double longitude,
  });
}
