import '../models/izin_sakit_model.dart';

abstract class IzinSakitRemoteDataSource {
  Future<IzinSakitModel> getActiveIzinSakit();
  Future<IzinSakitModel> submitLaporanAwalSakit({
    required DateTime startDate,
    required DateTime endDate,
    required int durationDays,
    required String keluhan,
  });
  Future<IzinSakitModel> submitBuktiSakit({
    required String attachmentName,
  });
}
