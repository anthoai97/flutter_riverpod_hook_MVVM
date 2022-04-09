import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';

String getRandomString(int length) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

void underDevelopment() {
  Fluttertoast.showToast(msg: 'Feature is under development');
}
