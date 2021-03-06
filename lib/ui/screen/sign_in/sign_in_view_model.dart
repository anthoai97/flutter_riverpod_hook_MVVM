import 'package:dayaway_partner/data/foundation/user_validator.dart';
import 'package:dayaway_partner/data/models/result.dart';
import 'package:dayaway_partner/ui/provider/auth_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

final sigInViewModelProvider =
    ChangeNotifierProvider((ref) => SignInViewModel(ref.read));

class SignInViewModel extends ChangeNotifier with UserInfoValidators {
  SignInViewModel(this._reader);

  final Reader _reader;

  late final AuthService _authService = _reader(authServiceProvider);

  final _passwordStreamController = BehaviorSubject<String>();
  final _emailStreamController = BehaviorSubject<String>();

  Function(String) get accountChanged => _emailStreamController.sink.add;

  Function(String) get passwordChanged => _passwordStreamController.sink.add;

  Stream<String> get account =>
      _emailStreamController.stream.transform(accountValidator);

  Stream<String> get password =>
      _passwordStreamController.stream.transform(passwordValidator);

  Stream<bool> get submitCheck =>
      CombineLatestStream.combine2(account, password, (e, p) => true);

  Future<Result> sigInWithEmailAndPassword() {
    return _authService.signInWithEmailAndPassword(
      _emailStreamController.value, _passwordStreamController.value,
      // 'admin.hcg@dayaway.com',
      // '123',
    );
  }
}
