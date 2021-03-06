import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pacific_dashboards/data/database/database.dart';
import 'package:pacific_dashboards/data/database/db_impl/accreditations_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/district_enroll_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/exams_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/indicators_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/individual_school_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/lookups_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/nation_enroll_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/school_enroll_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/school_exam_reports_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/school_flow_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/schools_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/short_school_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/special_education_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/strings_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/teachers_dao_impl.dart';
import 'package:pacific_dashboards/data/database/db_impl/wash_dao_impl.dart';
import 'package:pacific_dashboards/data/database/model/accreditation/hive_district_accreditation.dart';
import 'package:pacific_dashboards/data/database/model/accreditation/hive_national_accreditation.dart';
import 'package:pacific_dashboards/data/database/model/accreditation/hive_standard_accreditation.dart';
import 'package:pacific_dashboards/data/database/model/accreditation/hive_accreditation_chunk.dart';
import 'package:pacific_dashboards/data/database/model/budget/hive_budget.dart';
import 'package:pacific_dashboards/data/database/model/exam/hive_exam.dart';
import 'package:pacific_dashboards/data/database/model/indicators/hive_enrolment_by_level.dart';
import 'package:pacific_dashboards/data/database/model/indicators/hive_indicators_school_count.dart';
import 'package:pacific_dashboards/data/database/model/individual_school/hive_individual_school.dart';
import 'package:pacific_dashboards/data/database/model/individual_school/hive_individual_accreditation.dart';
import 'package:pacific_dashboards/data/database/model/lookup/hive_class_level_lookup.dart';
import 'package:pacific_dashboards/data/database/model/lookup/hive_lookup.dart';
import 'package:pacific_dashboards/data/database/model/lookup/hive_lookups.dart';
import 'package:pacific_dashboards/data/database/model/lookup/hive_school_type_lookup.dart';
import 'package:pacific_dashboards/data/database/model/school/hive_school.dart';
import 'package:pacific_dashboards/data/database/model/school_enroll/hive_school_enroll.dart';
import 'package:pacific_dashboards/data/database/model/school_exam_report/hive_school_exam_report.dart';
import 'package:pacific_dashboards/data/database/model/school_flow/hive_school_flow.dart';
import 'package:pacific_dashboards/data/database/model/short_school/hive_short_school.dart';
import 'package:pacific_dashboards/data/database/model/special_education/hive_special_education.dart';
import 'package:pacific_dashboards/data/database/model/teacher/hive_teacher.dart';
import 'package:pacific_dashboards/data/database/model/wash/hive_question.dart';
import 'package:pacific_dashboards/data/database/model/wash/hive_toilet.dart';
import 'package:pacific_dashboards/data/database/model/wash/hive_wash_chunk.dart';
import 'package:pacific_dashboards/data/database/model/wash/hive_wash_total.dart';
import 'package:pacific_dashboards/data/database/model/wash/hive_water.dart';

import 'budgets_dao_impl.dart';

///
///                         <<<release 1>>>
///                               ▿
/// typeIds {0, 1, 2, 3, 4, 5 ,6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22}
///
class HiveDatabase extends Database {
  LookupsDao _lookupsDao;
  StringsDao _stringsDao;
  SchoolsDao _schoolsDao;
  TeachersDao _teachersDao;
  ExamsDao _examsDao;
  IndicatorsDao _indicatorsDao;
  AccreditationsDao _accreditationsDao;
  SchoolEnrollDao _schoolEnroll;
  DistrictEnrollDao _districtEnroll;
  NationEnrollDao _nationEnroll;
  ShortSchoolDao _shortSchoolDao;
  SchoolFlowDao _schoolFlowDao;
  SchoolExamReportsDao _schoolExamReportsDao;
  BudgetsDao _budgetsDao;
  SpecialEducationDao _specialEducationDao;
  WashDao _washDao;
  IndividualSchoolDao _individualSchoolDao;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(HiveLookupsAdapter())
      ..registerAdapter(HiveLookupAdapter())
      ..registerAdapter(HiveSchoolTypeLookupAdapter())
      ..registerAdapter(HiveSchoolAdapter())
      ..registerAdapter(HiveTeacherAdapter())
      ..registerAdapter(HiveExamAdapter())
      ..registerAdapter(HiveEnrolmentByLevelAdapter())
      ..registerAdapter(HiveIndicatorsSchoolCountAdapter())
      ..registerAdapter(HiveStandardAccreditationAdapter())
      ..registerAdapter(HiveDistrictAccreditationAdapter())
      ..registerAdapter(HiveAccreditationChunkAdapter())
      ..registerAdapter(HiveSchoolEnrollAdapter())
      ..registerAdapter(HiveShortSchoolAdapter())
      ..registerAdapter(HiveSchoolFlowAdapter())
      ..registerAdapter(HiveClassLevelLookupAdapter())
      ..registerAdapter(HiveSchoolExamReportAdapter())
      ..registerAdapter(HiveBudgetAdapter())
      ..registerAdapter(HiveSpecialEducationAdapter())
      ..registerAdapter(HiveWashTotalAdapter())
      ..registerAdapter(HiveWashChunkAdapter())
      ..registerAdapter(HiveToiletAdapter())
      ..registerAdapter(HiveWaterAdapter())
      ..registerAdapter(HiveNationalAccreditationAdapter())
      ..registerAdapter(HiveIndividualSchoolAdapter())
      ..registerAdapter(HiveIndividualAccreditationAdapter())
      ..registerAdapter(HiveQuestionAdapter());

    _lookupsDao = HiveLookupsDao();

    final stringDao = HiveStringsDao();
    await stringDao.init();
    _stringsDao = stringDao;

    _schoolsDao = HiveSchoolsDao();
    _teachersDao = HiveTeachersDao();
    _examsDao = HiveExamsDao();
    _indicatorsDao = HiveIndicatorsDao();
    _accreditationsDao = HiveAccreditationsDao();
    _schoolEnroll = HiveSchoolEnrollDao();
    _districtEnroll = HiveDistrictEnrollDao();
    _nationEnroll = HiveNationEnrollDao();
    _shortSchoolDao = HiveShortSchoolDao();
    _schoolFlowDao = HiveSchoolFlowDao();
    _schoolExamReportsDao = HiveSchoolExamsReportDao();
    _budgetsDao = HiveBudgetsDao();
    _specialEducationDao = HiveSpecialEducationDao();
    _washDao = HiveWashDao();
    _individualSchoolDao = HiveIndividualSchoolDao();
  }

  @override
  LookupsDao get lookups => _lookupsDao;

  @override
  StringsDao get strings => _stringsDao;

  @override
  SchoolsDao get schools => _schoolsDao;

  @override
  TeachersDao get teachers => _teachersDao;

  @override
  ExamsDao get exams => _examsDao;

  @override
  AccreditationsDao get accreditations => _accreditationsDao;

  @override
  SchoolEnrollDao get schoolEnroll => _schoolEnroll;

  @override
  DistrictEnrollDao get districtEnroll => _districtEnroll;

  @override
  NationEnrollDao get nationEnroll => _nationEnroll;

  @override
  ShortSchoolDao get shortSchool => _shortSchoolDao;

  @override
  SchoolFlowDao get schoolFlow => _schoolFlowDao;

  @override
  SchoolExamReportsDao get schoolExamReports => _schoolExamReportsDao;

  @override
  BudgetsDao get budgets => _budgetsDao;

  @override
  SpecialEducationDao get specialEducation => _specialEducationDao;

  @override
  WashDao get wash => _washDao;

  @override
  IndividualSchoolDao get individualSchoolDao => _individualSchoolDao;

  @override
  IndicatorsDao get indicators => _indicatorsDao;


}
