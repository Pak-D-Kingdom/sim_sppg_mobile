import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/izin_darurat_entity.dart';
import '../repositories/izin_darurat_repository.dart';

class SubmitIzinDaruratParams {
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final String kategori;
  final String alasan;
  final String? attachmentName;

  const SubmitIzinDaruratParams({
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.kategori,
    required this.alasan,
    this.attachmentName,
  });
}

class SubmitIzinDarurat {
  final IzinDaruratRepository repository;

  SubmitIzinDarurat(this.repository);

  Future<Either<Failure, IzinDaruratData>> call(
      SubmitIzinDaruratParams params) async {
    return await repository.submitIzinDarurat(
      startDate: params.startDate,
      endDate: params.endDate,
      durationDays: params.durationDays,
      kategori: params.kategori,
      alasan: params.alasan,
      attachmentName: params.attachmentName,
    );
  }
}

class GetInitialIzinDarurat {
  final IzinDaruratRepository repository;

  GetInitialIzinDarurat(this.repository);

  Future<Either<Failure, IzinDaruratData>> call() async {
    return await repository.getInitialData();
  }
}
