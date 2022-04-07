import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class KeyboardHiderMixin {
  void hideKeyboard({
    BuildContext? context,
    bool hideTextInput = true,
    bool requestFocusNode = true,
  }) {
    if (hideTextInput) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    if (context != null && requestFocusNode) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    try {
      FocusManager.instance.primaryFocus?.unfocus();
    } catch (e) {
      //ignore
    }
  }
}
