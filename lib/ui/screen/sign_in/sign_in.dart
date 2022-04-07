import 'package:dayaway_partner/data/foundation/keyboard_hider.dart';
import 'package:dayaway_partner/data/foundation/log.dart';
import 'package:dayaway_partner/gen/assets.gen.dart';
import 'package:dayaway_partner/ui/component/dialog/custom_alert_dialog.dart';
import 'package:dayaway_partner/ui/component/error/error_text_input.dart';
import 'package:dayaway_partner/ui/component/input/mix_view.dart';
import 'package:dayaway_partner/ui/component/loading/container_with_loading.dart';
import 'package:dayaway_partner/ui/component/loading/loading_state_view_model.dart';
import 'package:dayaway_partner/ui/hook/use_dimensions.dart';
import 'package:dayaway_partner/ui/hook/use_router.dart';
import 'package:dayaway_partner/ui/screen/sign_in/sign_in_view_model.dart';
import 'package:dayaway_partner/ui/theme/app_text_theme.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:dayaway_partner/ui/theme/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends HookConsumerWidget with KeyboardHiderMixin {
  const SignInPage({Key? key, required this.onResult}) : super(key: key);

  final void Function(bool) onResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.read(loadingStateProvider);
    final router = useRouter();
    final screenUtils = useDimension();
    final theme = ref.watch(appThemeProvider);
    final viewModel = ref.read(sigInViewModelProvider);

    const double _fieldSpacing = DimensionsDef.globalPadding;
    const double _fieldLabelSpacing = 4;
    const double _fieldInputHeight = 44;

    final _emailTextController = useTextEditingController();
    final _passwordTextController = useTextEditingController();

    Widget _buildSubmitBtn() {
      return StreamBuilder<bool>(
          stream: viewModel.submitCheck,
          initialData: false,
          builder: (context, snapshot) {
            return Container(
              margin: const EdgeInsets.only(
                  top: _fieldSpacing + 12, bottom: _fieldSpacing),
              width: double.infinity,
              child: TextButton(
                onPressed: snapshot.hasData && snapshot.data!
                    ? () {
                        hideKeyboard();
                        loading.whileLoading(
                          () async {
                            return ref
                                .read(sigInViewModelProvider)
                                .sigInWithEmailAndPassword(
                                    _emailTextController.text,
                                    _passwordTextController.text)
                                .then(
                                  (value) => value.when(
                                    success: (data) {
                                      onResult(true);
                                      return null;
                                    },
                                    failure: (error) {
                                      showCustomFailAlertDialog(context,
                                          title: "Error",
                                          content: error.message,
                                          firstButtonText: "Close",
                                          firstButtonFunction: () =>
                                              router.pop());
                                      return null;
                                    },
                                  ),
                                );
                          },
                        );
                      }
                    : null,
                child: const Text('Login'),
              ),
            );
          });
    }

    return Scaffold(
      body: ContainerWithLoading(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: screenUtils.screenHeight * 2 / 3,
              child: Stack(
                children: [
                  Assets.images.imageLoginBackground.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: screenUtils.statusBarHeight + _fieldSpacing * 3,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome To\nThe World\nOf Dayaway',
                        style: theme.textTheme.h70
                            .copyWith(color: Colors.white, fontSize: 36)
                            .cormarant(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: double.infinity,
                height: screenUtils.screenHeight,
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(),
                      Container(
                        width: screenUtils.screenWidth,
                        constraints: BoxConstraints(
                            minHeight: screenUtils.screenHeight * 0.5),
                        padding: const EdgeInsets.all(_fieldSpacing),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: _fieldSpacing),
                              child: Text(
                                'Login'.toUpperCase(),
                                style: theme.textTheme.h50.bold(),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            // Field email
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: _fieldLabelSpacing),
                              child: Text(
                                'emailAddress',
                                style: theme.textTheme.h30,
                              ),
                            ),
                            StreamBuilder<Object>(
                                stream: viewModel.account,
                                builder: (context, snapshot) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MixedView(
                                        height: _fieldInputHeight,
                                        textHint: 'yourEmailAddress',
                                        hintStyle: theme.textTheme.h30.copyWith(
                                          color: theme.appColors.primary70,
                                        ),
                                        textController: _emailTextController,
                                        maxLines: 1,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        onChangedDataCallback:
                                            viewModel.accountChanged,
                                        borderColor: snapshot.hasError
                                            ? theme.appColors.error
                                            : null,
                                      ),
                                      ErrorTextInput(
                                          errorMessage: snapshot.hasError
                                              ? snapshot.error.toString()
                                              : null),
                                    ],
                                  );
                                }),
                            const SizedBox(height: _fieldSpacing),
                            // Field password
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: _fieldLabelSpacing),
                              child: Text(
                                'R.strings.password',
                                style: theme.textTheme.h30,
                              ),
                            ),
                            StreamBuilder<Object>(
                                stream: viewModel.password,
                                builder: (context, snapshot) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MixedView(
                                        height: _fieldInputHeight,
                                        textHint: "R.strings.yourPassword",
                                        hintStyle: theme.textTheme.h30.copyWith(
                                          color: theme.appColors.primary70,
                                        ),
                                        textController: _passwordTextController,
                                        onChangedDataCallback:
                                            viewModel.passwordChanged,
                                        maxLines: 1,
                                        obscureText: true,
                                        borderColor: snapshot.hasError
                                            ? theme.appColors.error
                                            : null,
                                      ),
                                      ErrorTextInput(
                                          errorMessage: snapshot.hasError
                                              ? snapshot.error.toString()
                                              : null),
                                    ],
                                  );
                                }),

                            // File extra
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: _fieldSpacing),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  GestureDetector(
                                    onTap: () {
                                      Log.debug("Forget password");
                                    },
                                    child: Text(
                                      'R.strings.forgotPassword',
                                      style: theme.textTheme.h30.bold(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            _buildSubmitBtn(),
                            const SizedBox(height: _fieldSpacing * 4),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
