import 'package:dayaway_partner/ui/component/nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Loading extends ConsumerWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          minHeight: double.infinity,
        ),
        color: Colors.white.withOpacity(0.3),
        child: NutsActivityIndicator(
          activeColor: theme.appColors.primary100,
          inactiveColor: theme.appColors.primary70,
          radius: 10.0,
        ),
      ),
    );
  }
}
