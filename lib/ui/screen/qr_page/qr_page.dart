import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QRPage extends HookConsumerWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRPage'),
      ),
    );
  }
}
