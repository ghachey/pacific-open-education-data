import 'package:arch/arch.dart';
import 'package:hive/hive.dart';
import 'package:pacific_dashboards/data/database/database.dart';
import 'package:pacific_dashboards/data/database/model/exam/hive_exam.dart';
import 'package:pacific_dashboards/data/database/model/indicators/hive_enrolment_by_level.dart';
import 'package:pacific_dashboards/data/database/model/indicators/hive_indicators_school_count.dart';
import 'package:pacific_dashboards/models/emis.dart';
import 'package:pacific_dashboards/models/exam/exam.dart';
import 'package:pacific_dashboards/models/indicators/indicators.dart';
import 'package:pacific_dashboards/models/indicators/indicators_container.dart';
import 'package:pacific_dashboards/models/indicators/indicators_enrolment_by_level.dart';
import 'package:pacific_dashboards/models/indicators/indicators_enrolments_by_level.dart';
import 'package:pacific_dashboards/models/indicators/indicators_school_count.dart';
import 'package:pacific_dashboards/models/indicators/indicators_school_counts.dart';

class HiveIndicatorsDao extends IndicatorsDao {
  static const _kKey = 'indicators';
  static const _enrolmentsKey = 'enrolments';
  static const _schoolCountsKey = 'schools';

  static Future<T> _withBox<T>(String typeKey,
      Future<T> action(Box<List> box)) async {
    final Box<List> box = await Hive.openBox(_kKey + typeKey);
    final result = await action(box);
    await box.close();
    return result;
  }

  @override
  Future<Pair<bool, IndicatorsContainer>> get(String districtCode, Emis emis) async {
    final storedEnrolments = await _withBox(
        _enrolmentsKey + districtCode, (box) async => box.get(emis.id));
    if (storedEnrolments == null) {
      return Pair(false, null);
    }
    var expired = false;
    List<IndicatorsEnrolmentByLevel> storedEnrolmentsItems = [];
    for (var value in storedEnrolments) {
      final hiveIndicatorsEnrolmentByLevel = value as HiveEnrolmentByLevel;
      expired |= hiveIndicatorsEnrolmentByLevel.isExpired();
      storedEnrolmentsItems.add(
          hiveIndicatorsEnrolmentByLevel.toIndicatorsEnrolmentByLevel());
    }

    final storedSchoolCounts = await _withBox(
        _schoolCountsKey + districtCode, (box) async => box.get(emis.id));
    if (storedEnrolments == null) {
      return Pair(false, null);
    }
    List<IndicatorsSchoolCount> storedSchoolCountsItems = [];
    for (var value in storedSchoolCounts) {
      final hiveIndicatorsEnrolmentByLevel = value as HiveIndicatorsSchoolCount;
      expired |= hiveIndicatorsEnrolmentByLevel.isExpired();
      storedSchoolCountsItems.add(
          hiveIndicatorsEnrolmentByLevel.toIndicatorsSchoolCount());
    }

    var indicatorsContainer = new IndicatorsContainer(
        indicators: new Indicators(schoolCounts: new IndicatorsSchoolCounts(
            schoolCounts: storedSchoolCountsItems),
            enrolments: new IndicatorsEnrolmentsByLevel(
                enrolments: storedEnrolmentsItems)));
    return Pair(expired, indicatorsContainer);
  }

  @override
  Future<void> save(IndicatorsContainer indicators, String districtCode,
      Emis emis) async {
    final hiveEnrolments = indicators.indicators.enrolments.enrolments
        .map((it) => HiveEnrolmentByLevel.from(it))
        .toList();

    final hiveSchoolCounts = indicators.indicators.schoolCounts.schoolCounts
        .map((it) => HiveIndicatorsSchoolCount.from(it))
        .toList();

    await _withBox(
        _enrolmentsKey + districtCode, (box) async =>
        box.put(emis.id, hiveEnrolments));
    await _withBox(
        _schoolCountsKey + districtCode, (box) async =>
        box.put(emis.id, hiveSchoolCounts));
  }
}
