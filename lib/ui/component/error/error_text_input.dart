import 'package:dayaway_partner/data/foundation/extentions/extention.dart';
import 'package:dayaway_partner/data/foundation/user_validator.dart';
import 'package:dayaway_partner/ui/hook/use_l10n.dart';
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
    final l10n = useL10n();

    String? text;

    switch (errorMessage) {
      case ValidateError.emailNotValid:
        text = l10n.emailNotValid;
        break;
      case ValidateError.emailRequired:
        text = l10n.emailRequired;
        break;
      case ValidateError.passwordChar:
        text = l10n.passwordChar(3);
        break;
      default:
        text = errorMessage;
    }

    return text.isTextEmpty
        ? Container()
        : Container(
            margin: margin ?? const EdgeInsets.only(top: 4),
            child: Text(
              text!,
              style: theme.textTheme.h10.copyWith(color: theme.appColors.error),
            ),
          );
  }
}
