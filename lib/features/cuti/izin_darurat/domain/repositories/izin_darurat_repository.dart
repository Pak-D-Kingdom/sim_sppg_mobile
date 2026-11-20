import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/izin_darurat_entity.dart';

abstract class IzinDaruratRepository {
  Future<Either<Failure, IzinDaruratData>> getInitialData();
  Future<Either<Failure, IzinDaruratData>> submitIzinDarurat({
    required DateTime startDate,
    required DateTime endDate,
    required int durationDays,
    required String kategori,
    required String alasan,
    String? attachmentName,
  });
}
