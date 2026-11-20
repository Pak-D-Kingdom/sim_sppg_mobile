import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/izin_sakit_entity.dart';
import '../repositories/izin_sakit_repository.dart';

class SubmitLaporanSakitParams {
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final String keluhan;

  const SubmitLaporanSakitParams({
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.keluhan,
  });
}

class SubmitLaporanSakit {
  final IzinSakitRepository repository;

  SubmitLaporanSakit(this.repository);

  Future<Either<Failure, IzinSakitData>> call(SubmitLaporanSakitParams params) async {
    return await repository.submitLaporanAwalSakit(
      startDate: params.startDate,
      endDate: params.endDate,
      durationDays: params.durationDays,
      keluhan: params.keluhan,
    );
  }
}
