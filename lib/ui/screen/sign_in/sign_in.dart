import 'package:dayaway_partner/ui/component/dialog/custom_alert_dialog.dart';
import 'package:dayaway_partner/ui/component/loading/container_with_loading.dart';
import 'package:dayaway_partner/ui/component/loading/loading_state_view_model.dart';
import 'package:dayaway_partner/ui/hook/use_router.dart';
import 'package:dayaway_partner/ui/screen/sign_in/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key, required this.onResult}) : super(key: key);

  final void Function(bool) onResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.read(loadingStateProvider);
    final viewModel = ref.read(sigInViewModelProvider);
    final router = useRouter();

    return Scaffold(
      appBar: AppBar(title: const Text('Sigin page')),
      body: ContainerWithLoading(
        child: Center(
          child: TextButton(
            onPressed: () {
              loading.whileLoading(
                () async {
                  return ref
                      .read(sigInViewModelProvider)
                      .sigInWithEmailAndPassword()
                      .then((value) => value.when(success: (data) {
                            onResult(true);
                            return null;
                          }, failure: (error) {
                            showCustomFailAlertDialog(context,
                                title: "Error",
                                content: error.message,
                                firstButtonText: "Close",
                                firstButtonFunction: () => router.pop());
                            return null;
                          }));
                },
              );
            },
            child: const Text('Login'),
          ),
        ),
      ),
    );
  }
}
