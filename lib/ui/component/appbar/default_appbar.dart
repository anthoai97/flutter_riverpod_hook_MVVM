import 'package:dayaway_partner/ui/theme/app_text_theme.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DayAwayAppBar {
  //
  static defaultAppBar(
    WidgetRef ref, {
    required String title,
    List<Widget>? action,
    TextStyle? textStyle,
    Color? backgroundColor,
  }) {
    final theme = ref.watch(appThemeProvider);
    return AppBar(
      title: Text(
        title,
        style: textStyle ?? theme.textTheme.h40.bold(),
      ),
      centerTitle: true,
      actions: action,
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }
  //
}
