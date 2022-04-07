import 'package:dayaway_partner/data/models/result.dart';
import 'package:dayaway_partner/ui/provider/auth_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sigInViewModelProvider =
    ChangeNotifierProvider((ref) => SignInViewModel(ref.read));

class SignInViewModel extends ChangeNotifier {
  SignInViewModel(this._reader);

  final Reader _reader;

  late final AuthService _authService = _reader(authServiceProvider);

  Future<Result> sigInWithEmailAndPassword() {
    return _authService.signInWithEmailAndPassword(
      'admin.hcg@dayaway.com',
      '123',
    );
  }
}
