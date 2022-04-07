import 'package:dayaway_partner/data/foundation/extentions/extention.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorTextInput extends HookConsumerWidget {
  const ErrorTextInput({
    Key? key,
    required this.errorMessage,
    this.margin,
  }) : super(key: key);

  final String? errorMessage;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return errorMessage.isTextEmpty
        ? Container()
        : Container(
            margin: margin ?? const EdgeInsets.only(top: 4),
            child: Text(
              errorMessage!,
              style: theme.textTheme.h10.copyWith(color: theme.appColors.error),
            ),
          );
  }
}
