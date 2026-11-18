import 'package:equatable/equatable.dart';

class OperationalAlert extends Equatable {
  final String category;
  final String badgeText;
  final String title;
  final String description;

  const OperationalAlert({
    required this.category,
    required this.badgeText,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [category, badgeText, title, description];
}
