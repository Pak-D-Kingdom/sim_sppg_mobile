import 'package:sim_sppg_mobile/core/network/dio_client.dart';
import '../models/payroll_data_model.dart';
import '../models/payroll_item_model.dart';
import 'payroll_remote_data_source.dart';

class PayrollRemoteDataSourceImpl implements PayrollRemoteDataSource {
  final DioClient dioClient;

  PayrollRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<PayrollDataModel> getPayrollData({int? year}) async {
    final targetYear = year ?? 2026;

    // Data sample sesuai screenshot desain
    return PayrollDataModel(
      title: 'Payroll',
      subtitle: 'SPPG Rawamangun 01 • Closing Tgl 25',
      selectedYear: targetYear,
      availableYears: const [2026, 2025, 2024],
      items: [
        const PayrollItemModel(
          id: 'nov-2026',
          monthYear: 'November 2026',
          isLatest: true,
          summaryText: '17/20 Hari • 3 Izin • 1x Telat',
          amount: 'Rp 6.075.000',
          status: 'Terbayar',
          detail: PayrollDetailModel(
            kehadiranValue: '17/20 Hari',
            kehadiranSubtitle: '1x Telat',
            cutiValue: '3 Hari',
            cutiSubtitle: 'Disetujui',
            dendaValue: '- Rp 25.000',
            dendaSubtitle: '1x Terlambat',
            rincianBannerSubtitle: 'Log telat & Insentif Nov 2026',
          ),
        ),
        const PayrollItemModel(
          id: 'okt-2026',
          monthYear: 'Oktober 2026',
          isLatest: false,
          summaryText: '20/20 Hari • Tanpa Denda',
          amount: 'Rp 6.100.000',
          status: 'Terbayar',
          detail: PayrollDetailModel(
            kehadiranValue: '20/20 Hari',
            kehadiranSubtitle: 'Tepat Waktu',
            cutiValue: '0 Hari',
            cutiSubtitle: '–',
            dendaValue: 'Rp 0',
            dendaSubtitle: 'Tanpa Denda',
            rincianBannerSubtitle: 'Log telat & Insentif Okt 2026',
          ),
        ),
        const PayrollItemModel(
          id: 'sep-2026',
          monthYear: 'September 2026',
          isLatest: false,
          summaryText: '20/20 Hari • Tanpa Denda',
          amount: 'Rp 6.100.000',
          status: 'Terbayar',
          detail: PayrollDetailModel(
            kehadiranValue: '20/20 Hari',
            kehadiranSubtitle: 'Tepat Waktu',
            cutiValue: '0 Hari',
            cutiSubtitle: '–',
            dendaValue: 'Rp 0',
            dendaSubtitle: 'Tanpa Denda',
            rincianBannerSubtitle: 'Log telat & Insentif Sep 2026',
          ),
        ),
        const PayrollItemModel(
          id: 'ags-2026',
          monthYear: 'Agustus 2026',
          isLatest: false,
          summaryText: '19/20 Hari • 1x Telat',
          amount: 'Rp 6.075.000',
          status: 'Terbayar',
          detail: PayrollDetailModel(
            kehadiranValue: '19/20 Hari',
            kehadiranSubtitle: '1x Telat',
            cutiValue: '1 Hari',
            cutiSubtitle: 'Disetujui',
            dendaValue: '- Rp 25.000',
            dendaSubtitle: '1x Terlambat',
            rincianBannerSubtitle: 'Log telat & Insentif Ags 2026',
          ),
        ),
        const PayrollItemModel(
          id: 'jul-2026',
          monthYear: 'Juli 2026',
          isLatest: false,
          summaryText: '20/20 Hari • Tanpa Denda',
          amount: 'Rp 6.100.000',
          status: 'Terbayar',
          detail: PayrollDetailModel(
            kehadiranValue: '20/20 Hari',
            kehadiranSubtitle: 'Tepat Waktu',
            cutiValue: '0 Hari',
            cutiSubtitle: '–',
            dendaValue: 'Rp 0',
            dendaSubtitle: 'Tanpa Denda',
            rincianBannerSubtitle: 'Log telat & Insentif Jul 2026',
          ),
        ),
      ],
    );
  }
}
