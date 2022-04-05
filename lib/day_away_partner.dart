import 'package:dayaway_partner/ui/routes/app_route.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class DayAwayPartner extends HookConsumerWidget {
  const DayAwayPartner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final appRouter = useMemoized(() => AppRouter());

    return MaterialApp.router(
      title: 'DayAway Partner',
      useInheritedMediaQuery: true,
      theme: theme.data,
      themeMode: themeMode,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
    );
  }
}
