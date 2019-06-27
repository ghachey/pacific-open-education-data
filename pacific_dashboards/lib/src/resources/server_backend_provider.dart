import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/schools_model.dart';
import '../utils/Exceptions/data_not_loaded_exception.dart';
import '../models/teachers_model.dart';

import 'Provider.dart';

class ServerBackendProvider implements Provider {
  static const String BASE_URL = "https://fedemis.doe.fm";
  static const String TEACHERS_API_KEY = "warehouse/teachercount";
  static const String SCHOOLS_API_KEY = "warehouse/examsdistrictresults";

  Client client = Client();

  Future<String> _request(String path) async {
    final webResponse = await client.get("$BASE_URL/api/$path").timeout(const Duration(minutes: 1));
    print(webResponse.body.toString());
    print('ServerBackendProvider');

    if (webResponse.statusCode == 200) {
      return webResponse.body;
    } else {
      throw DataNotLoadedException(path);
    }
  }

  @override
  Future<TeachersModel> fetchTeachersList() async {
    final responseData = await _request(TEACHERS_API_KEY);
    print('fetchTeachersList');
    return TeachersModel.fromJson(json.decode(responseData.toString()));
  }

  @override
  Future<SchoolsModel> fetchSchoolsList() async {
    final responseData = await _request(SCHOOLS_API_KEY);
    print('fetchSchoolsList');
    return SchoolsModel.fromJson(json.decode(responseData.toString()));
  }
}
