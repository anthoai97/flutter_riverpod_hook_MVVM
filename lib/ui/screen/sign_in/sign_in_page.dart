import 'package:dayaway_partner/data/foundation/keyboard_hider.dart';
import 'package:dayaway_partner/data/foundation/log.dart';
import 'package:dayaway_partner/gen/assets.gen.dart';
import 'package:dayaway_partner/ui/component/dialog/custom_alert_dialog.dart';
import 'package:dayaway_partner/ui/component/error/error_text_input.dart';
import 'package:dayaway_partner/ui/component/input/mix_view.dart';
import 'package:dayaway_partner/ui/component/loading/container_with_loading.dart';
import 'package:dayaway_partner/ui/component/loading/loading_state_view_model.dart';
import 'package:dayaway_partner/ui/hook/use_dimensions.dart';
import 'package:dayaway_partner/ui/hook/use_l10n.dart';
import 'package:dayaway_partner/ui/hook/use_router.dart';
import 'package:dayaway_partner/ui/screen/sign_in/sign_in_view_model.dart';
import 'package:dayaway_partner/ui/theme/app_text_theme.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:dayaway_partner/ui/theme/font_size.dart';
import 'package:flutter/material.dart';
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
    final l10n = useL10n();
    final viewModel = ref.read(sigInViewModelProvider);

    const double _fieldSpacing = DimensionsDef.globalPadding;
    const double _fieldLabelSpacing = 4;
    const double _fieldInputHeight = 44;

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
                                .sigInWithEmailAndPassword()
                                .then(
                                  (value) => value.when(
                                    success: (data, count, totalPage) {
                                      onResult(true);
                                      return null;
                                    },
                                    failure: (error) {
                                      showCustomFailAlertDialog(context,
                                          title: l10n.error,
                                          content: error.message,
                                          firstButtonText: l10n.ok,
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
                child: Text(l10n.login),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: _fieldSpacing * 2,
                            horizontal: _fieldSpacing),
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
                                l10n.login.toUpperCase(),
                                style: theme.textTheme.h50.bold(),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            // Field email
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: _fieldLabelSpacing),
                              child: Text(
                                l10n.email,
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
                                        textHint: l10n.yourEmailAddress,
                                        hintStyle: theme.textTheme.h30.copyWith(
                                          color: theme.appColors.primary70,
                                        ),
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
                                l10n.password,
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
                                        textHint: l10n.yourPassword,
                                        hintStyle: theme.textTheme.h30.copyWith(
                                          color: theme.appColors.primary70,
                                        ),
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
                                      l10n.forgotPassword,
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
