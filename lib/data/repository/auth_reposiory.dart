import 'package:dayaway_partner/data/models/keycloak.dart';
import 'package:dayaway_partner/data/models/result.dart';
import 'package:dayaway_partner/data/remote/auth/auth_resource.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class AuthRepository {
  Future<Result> loginKeyClock(Map<String, dynamic> body);
}

final authRepositoryImplProvider =
    Provider((ref) => AuthRepositoryImpl(ref.read));

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._reader);
  final Reader _reader;

  late final AuthDataSource _dataSource = _reader(authDataSourceProvider);

  @override
  Future<Result<KeyCloak>> loginKeyClock(Map<String, dynamic> body) async {
    return Result.guardFuture(() async {
      var result = await _dataSource.loginKeyClock(body);
      return KeyCloak.fromJson(result.data);
    });
  }
}
