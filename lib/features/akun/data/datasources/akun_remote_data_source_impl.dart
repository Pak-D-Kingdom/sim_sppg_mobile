import '../../../../core/network/dio_client.dart';
import '../models/akun_profile_model.dart';
import 'akun_remote_data_source.dart';

class AkunRemoteDataSourceImpl implements AkunRemoteDataSource {
  final DioClient dioClient;

  AkunRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<AkunProfileModel> getAkunProfile() async {
    return const AkunProfileModel(
      fullName: 'Siti Rahmawati, A.Md.Gz',
      roleLabel: 'Ahli Gizi • Pelaksana Gizi',
      locationBadge: 'SPPG Rawamangun 01',
      personnelId: 'SPPG-RMG-014',
      workTenure: '1 Thn 4 Bln',
      nik: '3175025408980004',
      email: 'siti.rahmawati@sppg.go.id',
      whatsappNumber: '0812-8490-3321',
      payrollAccount: 'BRI •••• 4829 (Terverifikasi)',
      mainShiftSchedule: 'Shift Pagi (05:00 - 13:00)',
      appVersionText: 'SIM-SPPG Mobile v2.4.0 • Badan Gizi Nasional',
      isOnline: true,
    );
  }
}
