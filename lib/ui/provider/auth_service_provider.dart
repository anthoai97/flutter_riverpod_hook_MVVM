import 'package:dayaway_partner/data/local/shared_pref_service.dart';
import 'package:dayaway_partner/data/models/keycloak.dart';
import 'package:dayaway_partner/data/models/result.dart';
import 'package:dayaway_partner/data/repository/auth_reposiory.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authServiceProvider = Provider((ref) => AuthService(ref.read));

class AuthService {
  AuthService(this._reader);

  final Reader _reader;

  late final SharedPreferencesService _preferencesService =
      _reader(sharedPrefServiceProvider);

  late final AuthRepositoryImpl _repositoryImpl =
      _reader(authRepositoryImplProvider);

  bool get isSignIn => _preferencesService.isSignIn;

  Future<Result<KeyCloak>> signInWithEmailAndPassword(
      String email, String password) async {
    final body = {
      'grant_type': 'password',
      'username': email,
      'password': password,
      'client_id': 'dayaway-hotelier-site'
    };

    var result = await _repositoryImpl.loginKeyClock(body);

    // Use success case
    result.ifSuccess((data) {
      _preferencesService.saveAuthToken(data.accessToken!);
      _preferencesService.saveRefreshToken(data.refreshToken!);
    });

    return result;
  }
}
