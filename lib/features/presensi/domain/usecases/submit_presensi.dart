import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/presensi_data.dart';
import '../repositories/presensi_repository.dart';

class GetPresensiStatus {
  final PresensiRepository repository;

  GetPresensiStatus(this.repository);

  Future<Either<Failure, PresensiData>> call({PresensiType? requestedType}) async {
    return await repository.getPresensiStatus(requestedType: requestedType);
  }
}

class SubmitClockIn {
  final PresensiRepository repository;

  SubmitClockIn(this.repository);

  Future<Either<Failure, PresensiData>> call({
    required String photoPath,
    double latitude = -6.1950,
    double longitude = 106.8820,
  }) async {
    return await repository.submitClockIn(
      photoPath: photoPath,
      latitude: latitude,
      longitude: longitude,
    );
  }
}

class SubmitClockOut {
  final PresensiRepository repository;

  SubmitClockOut(this.repository);

  Future<Either<Failure, PresensiData>> call({
    required String photoPath,
    double latitude = -6.1950,
    double longitude = 106.8820,
  }) async {
    return await repository.submitClockOut(
      photoPath: photoPath,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
