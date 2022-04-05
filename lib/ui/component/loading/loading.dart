import 'package:dayaway_partner/ui/component/nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Loading extends ConsumerWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return Center(
      child: NutsActivityIndicator(
        activeColor: theme.appColors.accent,
        radius: 8.0,
      ),
    );
  }
}
