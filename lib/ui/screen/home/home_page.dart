import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.read(appThemeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                if (themeMode == ThemeMode.dark) {
                  ref.read(appThemeModeProvider.notifier).state =
                      ThemeMode.light;
                } else {
                  ref.read(appThemeModeProvider.notifier).state =
                      ThemeMode.dark;
                }
              },
              child: Text(
                'Chagne THeme',
                style: theme.textTheme.h50,
              ),
            ),
          ),
          Text(
            'Chagne THeme',
            style: theme.textTheme.h50,
          ),
        ],
      ),
    );
  }
}
