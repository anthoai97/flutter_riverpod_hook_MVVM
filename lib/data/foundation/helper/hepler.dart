import 'package:dayaway_partner/data/foundation/shared_pref_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static Future<void> initLibrary() async {
    await Future.wait(
      [
        // SharedPrefManager
        _sharedPrefManager(),

        // Firebase
        // initFirebaseLibrary(),
        //
      ],
    );
  }

  static Future<void> _sharedPrefManager() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    SharedPrefManager(sharedPreferences: _pref);
  }

  static Future<void> initFirebaseLibrary() async {
    /// Firebase
    await Firebase.initializeApp();

    /// Crashlytics
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(kDebugMode);
    Function originalOnError = FlutterError.onError!;
    FlutterError.onError = (errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      originalOnError(errorDetails);
    };
  }
}
