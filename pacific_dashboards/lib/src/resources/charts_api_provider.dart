import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/teachers_model.dart';
import 'FileProviderImpl.dart';

class ChartsApiProvider {
  Client client = Client();

  final _dataApiKey = 'teachercount';

  Future<TeachersModel> fetchTeachersList() async {
      //return TeachersModel.fromJson(json.decode(await .loadFileData(_dataApiKey)));
  }
}
