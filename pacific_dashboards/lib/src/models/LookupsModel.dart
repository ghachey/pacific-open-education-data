class LookupsModel {
  static const String LOOKUPS_KEY_GOVT = "authorityGovt";
  static const String LOOKUPS_KEY_STATE = "districts";
  static const String LOOKUPS_KEY_AUTHORITY = "authorities";
  static const String LOOKUPS_KEY_STANDARD = "accreditationTerms";
  static const String LOOKUPS_KEY_SCHOOL_LEVEL = "schoolTypes";
  
  static const String LOOKUPS_KEY_NO_KEY = "";

  static const String LOOKUPS_KEY = "C";
  static const String LOOKUPS_VALUE = "N";

  Map<String, dynamic> _lookupsMap;

  LookupsModel.fromJson(Map parsedJson) {
    _lookupsMap = parsedJson;
  }

  String getFullGovt(String key) {
    return getFullName(key, LOOKUPS_KEY_GOVT);
  }

  String getFullState(String key) {
    return getFullName(key, LOOKUPS_KEY_STATE);
  }

  String getFullStandart(String key) {
    return getFullName(key, LOOKUPS_KEY_STANDARD); 
  }

  String getFullAuthority(String key) {
    return getFullName(key, LOOKUPS_KEY_AUTHORITY);
  }

    String getFullSchoolLevel(String key) {
    return getFullName(key, LOOKUPS_KEY_SCHOOL_LEVEL);
  }


  String getFullName(String key, String type) {
    try {
      if (!_lookupsMap.containsKey(type)) {
        return key;
      }
      List dataList = _lookupsMap[type];
      for (var val in dataList) {
        if (val[LOOKUPS_KEY] == key) {
          return val[LOOKUPS_VALUE];
        }
      }
      return key;
    } catch (e) {
      return key;
    }
  }

  toJson() {
    return _lookupsMap;
  }
}