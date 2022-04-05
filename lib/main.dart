import 'dart:async';

import 'package:dayaway_partner/data/foundation/helper/hepler.dart';
import 'package:dayaway_partner/day_away_partner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    debugPrint = (message, {wrapWidth}) {};
  }

  // Init Required Library
  await Helper.initLibrary();

  runZonedGuarded(() {
    runApp(const ProviderScope(child: DayAwayPartner()));
  }, (error, stackTrace) {
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
