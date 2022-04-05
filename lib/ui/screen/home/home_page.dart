import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              var themeMode = ref.read(appThemeModeProvider);
              if (themeMode == ThemeMode.dark) {
                ref.read(appThemeModeProvider.notifier).state = ThemeMode.light;
              } else {
                ref.read(appThemeModeProvider.notifier).state = ThemeMode.dark;
              }
            },
            child: const Text('Chagne THeme'),
          ),
          const Text('Chagne THeme'),
        ],
      ),
    );
  }
}
