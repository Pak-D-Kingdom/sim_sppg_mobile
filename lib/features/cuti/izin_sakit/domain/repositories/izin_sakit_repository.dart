import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/izin_sakit_entity.dart';

abstract class IzinSakitRepository {
  Future<Either<Failure, IzinSakitData>> getActiveIzinSakit();
  Future<Either<Failure, IzinSakitData>> submitLaporanAwalSakit({
    required DateTime startDate,
    required DateTime endDate,
    required int durationDays,
    required String keluhan,
  });
  Future<Either<Failure, IzinSakitData>> submitBuktiSakit({
    required String attachmentName,
  });
}
