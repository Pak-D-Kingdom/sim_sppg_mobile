import '../models/izin_darurat_model.dart';

abstract class IzinDaruratRemoteDataSource {
  Future<IzinDaruratModel> getInitialData();
  Future<IzinDaruratModel> submitIzinDarurat({
    required DateTime startDate,
    required DateTime endDate,
    required int durationDays,
    required String kategori,
    required String alasan,
    String? attachmentName,
  });
}
