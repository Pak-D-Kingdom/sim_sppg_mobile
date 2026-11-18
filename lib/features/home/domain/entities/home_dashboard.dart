import 'package:equatable/equatable.dart';
import 'home_menu.dart';
import 'home_statistic.dart';
import 'operational_alert.dart';
import 'quality_banner.dart';
import 'today_attendance.dart';

class HomeDashboard extends Equatable {
  final String appTitle;
  final String appVersion;
  final String agencyName;
  final String userName;
  final String userNik;
  final String userRole;
  final String employmentBadge;
  final String locationBadge;
  final int unreadNotifications;
  final OperationalAlert operationalAlert;
  final TodayAttendance todayAttendance;
  final List<HomeMenu> menus;
  final String summaryPeriod;
  final List<HomeStatistic> statistics;
  final QualityBanner qualityBanner;

  const HomeDashboard({
    this.appTitle = 'SIM-SPPG',
    this.appVersion = 'V2.0',
    required this.agencyName,
    required this.userName,
    this.userNik = '3175022010920003',
    required this.userRole,
    this.employmentBadge = 'Struktural',
    this.locationBadge = 'Rawamangun 01',
    required this.unreadNotifications,
    required this.operationalAlert,
    required this.todayAttendance,
    required this.menus,
    this.summaryPeriod = 'November 2026',
    required this.statistics,
    required this.qualityBanner,
  });

  HomeDashboard copyWith({
    String? appTitle,
    String? appVersion,
    String? agencyName,
    String? userName,
    String? userNik,
    String? userRole,
    String? employmentBadge,
    String? locationBadge,
    int? unreadNotifications,
    OperationalAlert? operationalAlert,
    TodayAttendance? todayAttendance,
    List<HomeMenu>? menus,
    String? summaryPeriod,
    List<HomeStatistic>? statistics,
    QualityBanner? qualityBanner,
  }) {
    return HomeDashboard(
      appTitle: appTitle ?? this.appTitle,
      appVersion: appVersion ?? this.appVersion,
      agencyName: agencyName ?? this.agencyName,
      userName: userName ?? this.userName,
      userNik: userNik ?? this.userNik,
      userRole: userRole ?? this.userRole,
      employmentBadge: employmentBadge ?? this.employmentBadge,
      locationBadge: locationBadge ?? this.locationBadge,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      operationalAlert: operationalAlert ?? this.operationalAlert,
      todayAttendance: todayAttendance ?? this.todayAttendance,
      menus: menus ?? this.menus,
      summaryPeriod: summaryPeriod ?? this.summaryPeriod,
      statistics: statistics ?? this.statistics,
      qualityBanner: qualityBanner ?? this.qualityBanner,
    );
  }

  @override
  List<Object?> get props => [
        appTitle,
        appVersion,
        agencyName,
        userName,
        userNik,
        userRole,
        employmentBadge,
        locationBadge,
        unreadNotifications,
        operationalAlert,
        todayAttendance,
        menus,
        summaryPeriod,
        statistics,
        qualityBanner,
      ];
}
