import 'package:sim_sppg_mobile/core/network/dio_client.dart';
import '../../domain/entities/izin_sakit_entity.dart';
import '../models/izin_sakit_model.dart';
import 'izin_sakit_remote_data_source.dart';

class IzinSakitRemoteDataSourceImpl implements IzinSakitRemoteDataSource {
  final DioClient dioClient;

  IzinSakitRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<IzinSakitModel> getActiveIzinSakit() async {
    // Default start at Tahap 1 (Laporan Awal Sakit)
    return IzinSakitModel(
      tahap: IzinSakitTahap.tahap1Form,
      startDate: DateTime(2026, 11, 20),
      endDate: DateTime(2026, 11, 20),
      durationDays: 1,
      keluhan: 'Demam tinggi dan pusing sejak subuh.',
      statusLaporan: 'Draft',
    );
  }

  @override
  Future<IzinSakitModel> submitLaporanAwalSakit({
    required DateTime startDate,
    required DateTime endDate,
    required int durationDays,
    required String keluhan,
  }) async {
    // When submitted to KSPPG, transition to Tahap 2 matching Gambar 2
    return IzinSakitModel(
      tahap: IzinSakitTahap.tahap2Unggah,
      startDate: startDate,
      endDate: endDate,
      durationDays: durationDays,
      keluhan: keluhan,
      statusLaporan: 'Diterima KSPPG',
      deadlineUnggah: DateTime(2026, 11, 22, 4, 52),
      remainingTimeText: 'Sisa 47j 58m',
    );
  }

  @override
  Future<IzinSakitModel> submitBuktiSakit({
    required String attachmentName,
  }) async {
    return IzinSakitModel(
      tahap: IzinSakitTahap.selesai,
      startDate: DateTime(2026, 11, 20),
      endDate: DateTime(2026, 11, 20),
      durationDays: 1,
      keluhan: 'Demam tinggi dan pusing sejak subuh.',
      statusLaporan: 'Disetujui KSPPG',
      attachmentName: attachmentName,
    );
  }
}
