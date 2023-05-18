import 'package:hive/hive.dart';

part 'survey.g.dart';

@HiveType(typeId: 0)
class Survey extends HiveObject {
  Survey({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.thankEmailAboveThreshold,
    required this.thankEmailBelowThreshold,
    required this.isActive,
    required this.coverImageUrl,
    required this.createdAt,
    required this.activeAt,
    required this.inactiveAt,
    required this.surveyType,
  });

  @HiveField(0, defaultValue: '')
  String id;
  @HiveField(1, defaultValue: '')
  String type;
  @HiveField(2, defaultValue: '')
  String title;
  @HiveField(3, defaultValue: '')
  String description;
  @HiveField(4, defaultValue: '')
  String thankEmailAboveThreshold;
  @HiveField(5, defaultValue: '')
  String thankEmailBelowThreshold;
  @HiveField(6, defaultValue: false)
  bool? isActive;
  @HiveField(7, defaultValue: '')
  String coverImageUrl;
  @HiveField(8, defaultValue: '')
  String createdAt;
  @HiveField(9, defaultValue: '')
  String activeAt;
  @HiveField(10, defaultValue: '')
  String inactiveAt;
  @HiveField(11, defaultValue: '')
  String surveyType;
}
