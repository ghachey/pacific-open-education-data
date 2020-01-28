import 'package:built_collection/built_collection.dart';
import 'package:pacific_dashboards/data/data_source/data_source.dart';
import 'package:pacific_dashboards/models/exams_model.dart';
import 'package:pacific_dashboards/models/lookups/lookups.dart';
import 'package:pacific_dashboards/models/school/school.dart';
import 'package:pacific_dashboards/models/school_accreditation_chunk.dart';
import 'package:pacific_dashboards/models/teachers_model.dart';

abstract class LocalDataSource extends DataSource {
  Future<void> saveExamsModel(ExamsModel model);

  Future<void> saveTeachersModel(TeachersModel model);

  Future<void> saveSchools(BuiltList<School> schools);

  Future<void> saveSchoolAccreditationsChunk(SchoolAccreditationsChunk chunk);

  Future<void> saveLookupsModel(Lookups model);
}
