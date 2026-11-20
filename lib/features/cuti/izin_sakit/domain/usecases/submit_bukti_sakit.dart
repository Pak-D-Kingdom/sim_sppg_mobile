import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/izin_sakit_entity.dart';
import '../repositories/izin_sakit_repository.dart';

class SubmitBuktiSakit {
  final IzinSakitRepository repository;

  SubmitBuktiSakit(this.repository);

  Future<Either<Failure, IzinSakitData>> call(String attachmentName) async {
    return await repository.submitBuktiSakit(
      attachmentName: attachmentName,
    );
  }
}
