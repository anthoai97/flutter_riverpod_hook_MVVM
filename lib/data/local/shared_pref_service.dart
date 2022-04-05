import 'package:dayaway_partner/data/foundation/constants.dart';
import 'package:dayaway_partner/data/foundation/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sharedPrefServiceProvider =
    Provider((_) => SharedPreferencesService(SharedPrefManager.instance));

class SharedPreferencesService {
  //
  final SharedPrefManager _sharedPrefManager;

  SharedPreferencesService(this._sharedPrefManager);

  // Theme
  String? get theme {
    return _sharedPrefManager.getData<String>(SharePreferenceKey.theme);
  }

  Future<bool> saveTheme(ThemeMode mode) =>
      _sharedPrefManager.setData(SharePreferenceKey.theme, mode.toString());

  //
}
