import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/cuti_form_data.dart';
import '../repositories/cuti_repository.dart';

class SubmitCuti implements UseCase<String, CutiFormData> {
  final CutiRepository repository;

  SubmitCuti(this.repository);

  @override
  Future<Either<Failure, String>> call(CutiFormData params) async {
    return await repository.submitCuti(params);
  }
}
