import 'package:equatable/equatable.dart';

class QualityBanner extends Equatable {
  final String tag;
  final String title;
  final String description;

  const QualityBanner({
    required this.tag,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [tag, title, description];
}
