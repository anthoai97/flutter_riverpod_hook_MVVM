import 'package:dayaway_partner/gen/assets.gen.dart';
import 'package:dayaway_partner/ui/hook/use_dimensions.dart';
import 'package:dayaway_partner/ui/theme/app_text_theme.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../theme/font_size.dart';

enum TypeAlert {
  success,
  fail,
  confirm,
}

class _CustomAlertDialog extends HookConsumerWidget {
  const _CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.firstButtonText,
    required this.firstButtonFunction,
    this.typeAlert = TypeAlert.confirm,
    this.secondButtonText = "",
    this.secondButtonFunction,
    this.titleAlign = TextAlign.center,
    this.contentAlign = TextAlign.center,
    this.allowPopScope = true,
    this.contentCustom,
  }) : super(key: key);

  final String title;
  final String content;
  final String firstButtonText;
  final Function firstButtonFunction;
  final String secondButtonText;
  final Function? secondButtonFunction;
  final Widget? contentCustom;
  final double _radius = 2;
  final double _spacing = 8.0;
  final TextAlign titleAlign;
  final TextAlign contentAlign;
  final bool allowPopScope;
  final TypeAlert typeAlert;

  Widget _renderIconAlert() {
    switch (typeAlert) {
      case TypeAlert.success:
        return Assets.svgs.icSuccess.svg(fit: BoxFit.contain);
      case TypeAlert.fail:
        return Assets.svgs.icFailed.svg(fit: BoxFit.contain);

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _renderTitle(AppTheme theme) {
    return Container(
      margin: EdgeInsets.only(
        bottom: _spacing,
        top: DimensionsDef.globalPadding,
      ),
      child: Column(
        children: [
          _renderIconAlert(),
          const SizedBox(
            height: 14,
          ),
          Text(
            title,
            style: theme.textTheme.h40.bold(),
          ),
        ],
      ),
    );
  }

  Widget _renderContent(AppTheme theme) {
    return Container(
      margin: EdgeInsets.only(
        left: DimensionsDef.globalPadding,
        right: DimensionsDef.globalPadding,
        top: _spacing,
        bottom: _spacing,
      ),
      child: contentCustom ??
          Text(
            content,
            textScaleFactor: 1.0,
            overflow: TextOverflow.ellipsis,
            textAlign: contentAlign,
            softWrap: true,
            maxLines: 100,
            style: theme.textTheme.h30,
          ),
    );
  }

  Widget _renderButton(bool _existSecondButton, {required AppTheme theme}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: DimensionsDef.globalPadding,
        right: DimensionsDef.globalPadding,
        top: 10,
        bottom: DimensionsDef.globalPadding,
      ),
      child: Row(
        children: <Widget>[
          // Second button
          (_existSecondButton
              ? Expanded(
                  child: OutlinedButton(
                    onPressed: () => secondButtonFunction!.call(),
                    child: Text(
                      secondButtonText,
                      // style: theme.textTheme.h30
                    ),
                  ),
                )
              : Container()),
          // Vertical Divider
          (_existSecondButton
              ? const SizedBox(
                  width: 15,
                )
              : Container()),
          // First button
          Expanded(
            child: TextButton(
              onPressed: () {
                firstButtonFunction.call();
              },
              child: Text(firstButtonText),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final screenUtils = useDimension();

    bool _existSecondButton = false;
    if (secondButtonText.isNotEmpty && secondButtonFunction != null) {
      _existSecondButton = true;
    }

    Widget element = Container(
      constraints: BoxConstraints(maxWidth: screenUtils.screenWidth * 0.85),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Title
          _renderTitle(theme),
          // Content
          _renderContent(theme),
          // Button
          _renderButton(_existSecondButton, theme: theme),
        ],
      ),
    );
    return WillPopScope(
      onWillPop: () {
        return Future.value(allowPopScope);
      },
      child: element,
    );
  }
}

Future<T?> showCustomSuccessAlertDialog<T>(
  BuildContext context, {
  Key? key,
  required title,
  required content,
  required firstButtonText,
  required firstButtonFunction,
  secondButtonText = "",
  secondButtonFunction,
  TextAlign titleAlign = TextAlign.center,
  TextAlign contentAlign = TextAlign.center,
  bool barrierDismissible = true,
  bool allowPopScope = true,
}) async {
  return await showGeneralDialog(
    context: context,
    barrierLabel: "Label",
    barrierDismissible: barrierDismissible,
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: anim1,
            curve: Curves.linear,
          ),
        ),
        child: child,
      );
    },
    pageBuilder: (context, anim1, anim2) {
      return Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.center,
          child: _CustomAlertDialog(
            title: title,
            content: content,
            firstButtonText: firstButtonText,
            firstButtonFunction: firstButtonFunction,
            secondButtonText: secondButtonText,
            secondButtonFunction: secondButtonFunction,
            titleAlign: titleAlign,
            contentAlign: contentAlign,
            allowPopScope: allowPopScope,
            typeAlert: TypeAlert.success,
          ),
        ),
      );
    },
  );
}

Future<T?> showCustomFailAlertDialog<T>(
  BuildContext context, {
  Key? key,
  required title,
  required content,
  required firstButtonText,
  required firstButtonFunction,
  secondButtonText = "",
  secondButtonFunction,
  TextAlign titleAlign = TextAlign.center,
  TextAlign contentAlign = TextAlign.center,
  bool barrierDismissible = true,
  bool allowPopScope = true,
}) async {
  return await showGeneralDialog(
    context: context,
    barrierLabel: "Label",
    barrierDismissible: barrierDismissible,
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: anim1,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: child,
      );
    },
    pageBuilder: (context, anim1, anim2) {
      return Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.center,
          child: _CustomAlertDialog(
            title: title,
            content: content,
            firstButtonText: firstButtonText,
            firstButtonFunction: firstButtonFunction,
            secondButtonText: secondButtonText,
            secondButtonFunction: secondButtonFunction,
            titleAlign: titleAlign,
            contentAlign: contentAlign,
            allowPopScope: allowPopScope,
            typeAlert: TypeAlert.fail,
          ),
        ),
      );
    },
  );
}

Future<T?> showCustomConfirmAlertDialog<T>(
  BuildContext context, {
  Key? key,
  required title,
  required content,
  required firstButtonText,
  required firstButtonFunction,
  String secondButtonText = "",
  VoidCallback? secondButtonFunction,
  TextAlign titleAlign = TextAlign.center,
  TextAlign contentAlign = TextAlign.center,
  bool barrierDismissible = true,
  bool allowPopScope = true,
  Widget? contentCustom,
}) async {
  return await showGeneralDialog(
    context: context,
    barrierLabel: "Label",
    barrierDismissible: barrierDismissible,
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: anim1,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: child,
      );
    },
    pageBuilder: (context, anim1, anim2) {
      return Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.center,
          child: _CustomAlertDialog(
            title: title,
            content: content,
            firstButtonText: firstButtonText,
            firstButtonFunction: firstButtonFunction,
            secondButtonText: secondButtonText,
            secondButtonFunction: secondButtonFunction,
            titleAlign: titleAlign,
            contentAlign: contentAlign,
            allowPopScope: allowPopScope,
            typeAlert: TypeAlert.confirm,
            contentCustom: contentCustom,
          ),
        ),
      );
    },
  );
}
