import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/riwayat_absen_data.dart';
import '../repositories/riwayat_absen_repository.dart';

class GetRiwayatAbsen {
  final RiwayatAbsenRepository repository;

  GetRiwayatAbsen(this.repository);

  Future<Either<Failure, RiwayatAbsenData>> call(
    GetRiwayatAbsenParams params,
  ) {
    return repository.getRiwayatAbsen(
      month: params.month,
      year: params.year,
    );
  }
}

class GetRiwayatAbsenParams extends Equatable {
  final int month;
  final int year;

  const GetRiwayatAbsenParams({
    required this.month,
    required this.year,
  });

  @override
  List<Object?> get props => [month, year];
}
