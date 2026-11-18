import 'package:equatable/equatable.dart';

class HomeMenu extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final String route;
  final String? badgeText;
  final String theme; // 'green', 'blue', 'amber', 'red'

  const HomeMenu({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    this.badgeText,
    this.theme = 'green',
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        icon,
        route,
        badgeText,
        theme,
      ];
}
