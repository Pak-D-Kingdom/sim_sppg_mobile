import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/notification_model.dart';
import 'notification_remote_data_source.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioClient dioClient;

  // In-memory cache to allow interactive mark-as-read in demo / offline mode
  List<NotificationModel>? _cachedNotifications;

  NotificationRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    if (_cachedNotifications != null) {
      return List<NotificationModel>.from(_cachedNotifications!);
    }

    try {
      final response = await dioClient.get(ApiEndpoints.notifications);
      if (response.statusCode == 200 && response.data != null) {
        final list = response.data is List
            ? response.data as List
            : (response.data['data'] as List? ?? []);
        _cachedNotifications = list
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return _cachedNotifications!;
      } else {
        _cachedNotifications = _getSampleNotifications();
        return _cachedNotifications!;
      }
    } catch (_) {
      _cachedNotifications = _getSampleNotifications();
      return _cachedNotifications!;
    }
  }

  @override
  Future<List<NotificationModel>> markNotificationAsRead(String id) async {
    final current = await getNotifications();
    _cachedNotifications = current.map((item) {
      if (item.id == id) {
        return item.copyWith(isRead: true);
      }
      return item;
    }).toList();
    return List<NotificationModel>.from(_cachedNotifications!);
  }

  @override
  Future<List<NotificationModel>> markAllNotificationsAsRead() async {
    final current = await getNotifications();
    _cachedNotifications = current.map((item) {
      return item.copyWith(isRead: true);
    }).toList();
    return List<NotificationModel>.from(_cachedNotifications!);
  }

  List<NotificationModel> _getSampleNotifications() {
    return const [
      NotificationModel(
        id: '1',
        category: 'PERINGATAN OPERASIONAL',
        type: 'operasional',
        title: '28 Nov 2026 — Pembersihan Menyeluruh & Pest Control Dapur',
        description:
            'Dapur Sentral LIBUR TOTAL OPERASIONAL. Pastikan seluruh bahan baku tertutup rapat & bersertifikat food-grade.',
        timestamp: '20 Nov 2026 • 08:00 WIB',
        isRead: false,
        section: 'HARI INI',
      ),
      NotificationModel(
        id: '2',
        category: 'PENGAJUAN CUTI',
        type: 'persetujuan',
        title: 'Pengajuan Cuti Menunggu Persetujuan',
        description:
            'Rizky Pratama (Koki Produksi) mengajukan Cuti Tahunan selama 2 hari (24–25 Nov 2026).',
        timestamp: '20 Nov 2026 • 07:15 WIB',
        isRead: false,
        section: 'HARI INI',
      ),
      NotificationModel(
        id: '3',
        category: 'PRESENSI HARIAN',
        type: 'operasional',
        title: 'Clock-In Berhasil (Tepat Waktu)',
        description:
            'Presensi masuk shift pagi tercatat pada pukul 04:52 WIB di SPPG Rawamangun 01.',
        timestamp: '20 Nov 2026 • 04:52 WIB',
        isRead: true,
        section: 'HARI INI',
      ),
    ];
  }
}
