import 'package:auto_route/auto_route.dart';
import 'package:dayaway_partner/ui/provider/auth_service_provider.dart';
import 'package:dayaway_partner/ui/routes/app_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authGuardProvider = Provider<AuthGuard>(((ref) => AuthGuard(ref.read)));

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._reader);

  final Reader _reader;

  late final AuthService _authService = _reader(authServiceProvider);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    bool authenitcated = _authService.isSignIn;
    if (authenitcated) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.push(
        SignInRoute(
          onResult: (success) {
            // if success == true the navigation will be resumed
            // else it will be aborted
            resolver.next(success);
            router.removeLast();
          },
        ),
      );
    }
  }
}
