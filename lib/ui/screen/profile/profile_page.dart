import 'package:dayaway_partner/data/local/shared_pref_service.dart';
import 'package:dayaway_partner/ui/component/widget/restart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePage Page'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Logout'),
          onPressed: () {
            ref.read(sharedPrefServiceProvider).removeAll();
            RestartWidget.restartApp(context);
          },
        ),
      ),
    );
  }
}
