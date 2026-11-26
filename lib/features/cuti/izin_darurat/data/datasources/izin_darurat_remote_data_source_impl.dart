import 'package:sim_sppg_mobile/core/network/dio_client.dart';
import '../../domain/entities/izin_darurat_entity.dart';
import '../models/izin_darurat_model.dart';
import 'izin_darurat_remote_data_source.dart';

class IzinDaruratRemoteDataSourceImpl implements IzinDaruratRemoteDataSource {
  final DioClient dioClient;

  IzinDaruratRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<IzinDaruratModel> getInitialData() async {
    return IzinDaruratModel(
      jenis: IzinDaruratJenis.tidakMasuk,
      startDate: DateTime(2026, 11, 20),
      endDate: DateTime(2026, 11, 20),
      durationDays: 1,
      jamTiba: '06:15 WIB',
      jadwalMasuk: '05:00 WIB',
      menitTerlambat: 75,
      kuotaCuti: 5,
      kategori: 'Keluarga Rawat Darurat',
      alasan: 'Anggota keluarga inti masuk IGD RSUD pagi ini.',
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
