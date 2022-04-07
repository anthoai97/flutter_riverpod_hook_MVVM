import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static SharedPrefManager get instance => _instance;

  factory SharedPrefManager({
    required SharedPreferences sharedPreferences,
  }) {
    _instance._sharedPreferences = sharedPreferences;
    return _instance;
  }

  /*
    + Private functions
  */

  static final SharedPrefManager _instance =
      SharedPrefManager._privateConstructor();

  SharedPrefManager._privateConstructor();

  late SharedPreferences _sharedPreferences;

  bool _hasValidKeyLength(String key) {
    return (key.isEmpty) ? false : true;
  }

  bool _isSuitableGetKey(String key) {
    return (!_hasValidKeyLength(key) || !_sharedPreferences.containsKey(key))
        ? false
        : true;
  }

  /*
    + Other Functions
  */
  bool containsKey(String key) {
    if (!_hasValidKeyLength(key)) return false;
    return _sharedPreferences.containsKey(key) ? true : false;
  }

  void removeAllData() {
    _sharedPreferences.clear();
  }

  /*
    + Set & get data with common variable types
  */
  Future<bool> setData(String key, dynamic data) async {
    if (!_hasValidKeyLength(key)) return false;
    if (data is int) {
      return _sharedPreferences.setInt(key, data);
    } else if (data is bool) {
      return _sharedPreferences.setBool(key, data);
    } else if (data is double) {
      return _sharedPreferences.setDouble(key, data);
    } else if (data is String) {
      return _sharedPreferences.setString(key, data);
    } else if (data is List<String>) {
      return _sharedPreferences.setStringList(key, data);
    } else {
      throw UnsupportedError('The specified data type for setting is invalid.');
    }
  }

  dynamic getData<T>(String key) {
    if (!_isSuitableGetKey(key)) return null;
    if (T.toString().compareTo("int") == 0) {
      return _sharedPreferences.getInt(key);
    } else if (T.toString().compareTo("bool") == 0) {
      return _sharedPreferences.getBool(key);
    } else if (T.toString().compareTo("double") == 0) {
      return _sharedPreferences.getDouble(key);
    } else if (T.toString().compareTo("String") == 0) {
      return _sharedPreferences.getString(key);
    } else if (T.toString().compareTo("List<String>") == 0) {
      return _sharedPreferences.getStringList(key);
    } else {
      throw UnsupportedError(
        'The specified data type for getting is invalid',
      );
    }
  }

  /*
    + Remove an entry from sharedpref
  */
  Future<bool> removeData(String key) async {
    if (!_isSuitableGetKey(key)) return false;
    return _sharedPreferences.remove(key);
  }

  /*
    + Set & get data with other variable types
  */
  void setMapData(String key, Map data) {
    if (!_hasValidKeyLength(key)) return;
    String obj = json.encode(data);
    _sharedPreferences.setString(key, obj);
  }

  Future<void> setMapSync(String key, Map data) async {
    if (!_hasValidKeyLength(key)) return;
    String obj = json.encode(data);
    await _sharedPreferences.setString(key, obj);
  }

  Map? getMapData(String key) {
    if (!_isSuitableGetKey(key)) return null;
    String data = _sharedPreferences.getString(key)!;
    return json.decode(data);
  }
}
