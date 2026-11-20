import 'package:sim_sppg_mobile/core/network/dio_client.dart';
import '../models/izin_darurat_model.dart';
import 'izin_darurat_remote_data_source.dart';

class IzinDaruratRemoteDataSourceImpl implements IzinDaruratRemoteDataSource {
  final DioClient dioClient;

  IzinDaruratRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<IzinDaruratModel> getInitialData() async {
    return IzinDaruratModel(
      startDate: DateTime(2026, 11, 20),
      endDate: DateTime(2026, 11, 20),
      durationDays: 1,
      kategori: 'Keluarga Sakit Kritis',
      alasan: 'Keluarga inti masuk IGD mendadak.',
      statusPengajuan: null,
    );
  }

  @override
  Future<IzinDaruratModel> submitIzinDarurat({
    required DateTime startDate,
    required DateTime endDate,
    required int durationDays,
    required String kategori,
    required String alasan,
    String? attachmentName,
  }) async {
    return IzinDaruratModel(
      startDate: startDate,
      endDate: endDate,
      durationDays: durationDays,
      kategori: kategori,
      alasan: alasan,
      attachmentName: attachmentName,
      statusPengajuan: 'Diteruskan ke Koordinator Unit SPPG Rawamangun 01',
    );
  }
}
