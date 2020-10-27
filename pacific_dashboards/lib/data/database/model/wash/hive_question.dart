import 'package:hive/hive.dart';
import 'package:pacific_dashboards/data/database/model/expirable.dart';
import 'package:pacific_dashboards/models/wash/question.dart';

part 'hive_question.g.dart';

@HiveType(typeId: 21)
class HiveQuestion extends HiveObject with Expirable {
  @HiveField(0)
  String qID;

  @HiveField(1)
  int qName;

  Question toQuestion() => Question(
      qID,
      qName);

  static HiveQuestion from(Question question) => HiveQuestion()
    ..qID = question.qID
    ..qName = question.qName;
}