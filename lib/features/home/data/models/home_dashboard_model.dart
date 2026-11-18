import '../../domain/entities/home_dashboard.dart';
import 'home_menu_model.dart';
import 'home_statistic_model.dart';
import 'operational_alert_model.dart';
import 'quality_banner_model.dart';
import 'today_attendance_model.dart';

class HomeDashboardModel extends HomeDashboard {
  const HomeDashboardModel({
    super.appTitle,
    super.appVersion,
    required super.agencyName,
    required super.userName,
    super.userNik,
    required super.userRole,
    super.employmentBadge,
    super.locationBadge,
    required super.unreadNotifications,
    required super.operationalAlert,
    required super.todayAttendance,
    required super.menus,
    super.summaryPeriod,
    required super.statistics,
    required super.qualityBanner,
  });

  factory HomeDashboardModel.fromJson(Map<String, dynamic> json) {
    return HomeDashboardModel(
      appTitle: json['appTitle'] ?? 'SIM-SPPG',
      appVersion: json['appVersion'] ?? 'V2.0',
      agencyName: json['agencyName'] ?? 'SPPG Rawamangun Sentral 01',
      userName: json['userName'] ?? '',
      userNik: json['userNik'] ?? '',
      userRole: json['userRole'] ?? '',
      employmentBadge: json['employmentBadge'] ?? 'Struktural',
      locationBadge: json['locationBadge'] ?? 'Rawamangun 01',
      unreadNotifications: json['unreadNotifications'] is int
          ? json['unreadNotifications']
          : int.tryParse(json['unreadNotifications']?.toString() ?? '0') ?? 0,
      operationalAlert: json['operationalAlert'] != null
          ? OperationalAlertModel.fromJson(
              json['operationalAlert'] as Map<String, dynamic>,
            )
          : const OperationalAlertModel(
              category: 'PERINGATAN\nOPERASIONAL',
              badgeText: 'H-3\nPelaksanaan',
              title: '',
              description: '',
            ),
      todayAttendance: json['todayAttendance'] != null
          ? TodayAttendanceModel.fromJson(
              json['todayAttendance'] as Map<String, dynamic>,
            )
          : const TodayAttendanceModel(
              dateFormatted: '',
              statusText: '',
              shiftLabel: '',
              shiftSchedule: '',
              clockInTime: '',
              clockInStatus: '',
              clockOutTime: '',
              clockOutStatus: '',
            ),
      menus: (json['menus'] as List<dynamic>?)
              ?.map((e) => HomeMenuModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      summaryPeriod: json['summaryPeriod'] ?? 'November 2026',
      statistics: (json['statistics'] as List<dynamic>?)
              ?.map(
                (e) => HomeStatisticModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      qualityBanner: json['qualityBanner'] != null
          ? QualityBannerModel.fromJson(
              json['qualityBanner'] as Map<String, dynamic>,
            )
          : const QualityBannerModel(
              tag: 'STANDAR MUTU SPPG',
              title: '',
              description: '',
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appTitle': appTitle,
      'appVersion': appVersion,
      'agencyName': agencyName,
      'userName': userName,
      'userNik': userNik,
      'userRole': userRole,
      'employmentBadge': employmentBadge,
      'locationBadge': locationBadge,
      'unreadNotifications': unreadNotifications,
      'operationalAlert': (operationalAlert is OperationalAlertModel
              ? operationalAlert as OperationalAlertModel
              : OperationalAlertModel(
                  category: operationalAlert.category,
                  badgeText: operationalAlert.badgeText,
                  title: operationalAlert.title,
                  description: operationalAlert.description,
                ))
          .toJson(),
      'todayAttendance': (todayAttendance is TodayAttendanceModel
              ? todayAttendance as TodayAttendanceModel
              : TodayAttendanceModel(
                  dateFormatted: todayAttendance.dateFormatted,
                  statusText: todayAttendance.statusText,
                  shiftLabel: todayAttendance.shiftLabel,
                  shiftSchedule: todayAttendance.shiftSchedule,
                  clockInTime: todayAttendance.clockInTime,
                  clockInStatus: todayAttendance.clockInStatus,
                  clockOutTime: todayAttendance.clockOutTime,
                  clockOutStatus: todayAttendance.clockOutStatus,
                  isClockedOut: todayAttendance.isClockedOut,
                ))
          .toJson(),
      'menus': menus
          .map(
            (e) => (e is HomeMenuModel
                    ? e
                    : HomeMenuModel(
                        id: e.id,
                        title: e.title,
                        subtitle: e.subtitle,
                        icon: e.icon,
                        route: e.route,
                        badgeText: e.badgeText,
                        theme: e.theme,
                      ))
                .toJson(),
          )
          .toList(),
      'summaryPeriod': summaryPeriod,
      'statistics': statistics
          .map(
            (e) => (e is HomeStatisticModel
                    ? e
                    : HomeStatisticModel(
                        id: e.id,
                        title: e.title,
                        value: e.value,
                        unit: e.unit,
                        footer: e.footer,
                        code: e.code,
                      ))
                .toJson(),
          )
          .toList(),
      'qualityBanner': (qualityBanner is QualityBannerModel
              ? qualityBanner as QualityBannerModel
              : QualityBannerModel(
                  tag: qualityBanner.tag,
                  title: qualityBanner.title,
                  description: qualityBanner.description,
                ))
          .toJson(),
    };
  }
}
