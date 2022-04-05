import 'package:dayaway_partner/ui/screen/home/home_page.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DayAwayPartner extends HookConsumerWidget {
  const DayAwayPartner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    // final appRouter = useMemoized(() => AppRouter());

    return MaterialApp(
      title: 'DayAway Partner',
      useInheritedMediaQuery: true,
      theme: theme.data,
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
