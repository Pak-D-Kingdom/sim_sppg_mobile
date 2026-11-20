import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/jadwal_data.dart';
import '../repositories/jadwal_repository.dart';

class GetJadwalParams extends Equatable {
  final int? month;
  final int? year;

  const GetJadwalParams({this.month, this.year});

  @override
  List<Object?> get props => [month, year];
}

class GetJadwal implements UseCase<JadwalData, GetJadwalParams> {
  final JadwalRepository repository;

  GetJadwal(this.repository);

  @override
  Future<Either<Failure, JadwalData>> call(GetJadwalParams params) async {
    return await repository.getJadwal(
      month: params.month,
      year: params.year,
    );
  }
}
