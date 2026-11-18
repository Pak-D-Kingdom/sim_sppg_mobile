import '../../domain/entities/home_menu.dart';

class HomeMenuModel extends HomeMenu {
  const HomeMenuModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.icon,
    required super.route,
    super.badgeText,
    super.theme,
  });

  factory HomeMenuModel.fromJson(Map<String, dynamic> json) {
    return HomeMenuModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      icon: json['icon'] ?? '',
      route: json['route'] ?? '',
      badgeText: json['badgeText']?.toString(),
      theme: json['theme'] ?? 'green',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'icon': icon,
      'route': route,
      'badgeText': badgeText,
      'theme': theme,
    };
  }
}
