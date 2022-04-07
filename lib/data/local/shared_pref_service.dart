import 'package:dayaway_partner/data/foundation/constants.dart';
import 'package:dayaway_partner/data/foundation/helper/shared_pref_manager.dart';
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

  // Auth
  String? get authToken {
    final token =
        _sharedPrefManager.getData<String>(SharePreferenceKey.authToken);
    return token != null && token.isNotEmpty ? token : null;
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPrefManager.setData(SharePreferenceKey.authToken, authToken);
  }

  String? get refreshToken {
    final token =
        _sharedPrefManager.getData<String>(SharePreferenceKey.refreshToken);
    return token != null && token.isNotEmpty ? token : null;
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    return _sharedPrefManager.setData(
        SharePreferenceKey.refreshToken, refreshToken);
  }

  bool get isSignIn => authToken != null ? true : false;
}
