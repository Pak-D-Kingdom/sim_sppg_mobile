import '../../domain/entities/quality_banner.dart';

class QualityBannerModel extends QualityBanner {
  const QualityBannerModel({
    required super.tag,
    required super.title,
    required super.description,
  });

  factory QualityBannerModel.fromJson(Map<String, dynamic> json) {
    return QualityBannerModel(
      tag: json['tag'] ?? 'STANDAR MUTU SPPG',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'title': title,
      'description': description,
    };
  }
}
