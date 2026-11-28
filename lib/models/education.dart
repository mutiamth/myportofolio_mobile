import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Education {
  const Education({
    this.id,
    required this.institution,
    required this.degree,
    required this.startYear,
    this.endYear,
    this.starCount = 0,
    this.isStarred = false,
  });

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);

  @JsonKey(includeToJson: false)
  final int? id;

  final String institution;
  final String degree;
  final int startYear;
  final int? endYear;

  @JsonKey(defaultValue: 0)
  final int starCount;

  @JsonKey(defaultValue: false)
  final bool isStarred;

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}
