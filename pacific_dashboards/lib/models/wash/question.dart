import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  @JsonKey(name: 'QID') //Year
  final String qID;
  @override
  @JsonKey(name: "QName") //DistrictCode
  final int qName;


  const Question(
      this.qID,
      this.qName);
   

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}