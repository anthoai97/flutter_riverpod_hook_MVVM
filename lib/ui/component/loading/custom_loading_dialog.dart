import 'package:dayaway_partner/ui/component/nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:dayaway_partner/ui/hook/use_l10n.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _CustomLoadingDialog extends HookConsumerWidget {
  final double _radius = 2;
  final double _spacing = 15;
  final double _dialogWidth = 120;
  final double _dialogHeight = 120;
  final String? text;

  const _CustomLoadingDialog({required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    Widget _buildElement = Container(
      width: _dialogWidth,
      height: _dialogHeight,
      margin: EdgeInsets.only(
        left: _spacing,
        right: _spacing,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
        color: theme.appColors.primary100,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          NutsActivityIndicator(
            activeColor: Colors.white,
            inactiveColor: theme.appColors.primary70,
            radius: 20,
            tickCount: 14,
            relativeWidth: 0.5,
          ),
          const SizedBox(height: 10),
          Text(
            text ?? l10n.loading,
            textScaleFactor: 1.0,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.h30,
          ),
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: _buildElement,
    );
  }
}

Future<T?> showCustomLoadingDialog<T>(BuildContext context,
    {String? text = ""}) async {
  return await showGeneralDialog<T>(
    context: context,
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 500),
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
          child: _CustomLoadingDialog(text: text),
        ),
      );
    },
  );
}
