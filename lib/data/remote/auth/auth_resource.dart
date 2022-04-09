import 'package:dayaway_partner/data/foundation/constants.dart';
import 'package:dayaway_partner/data/models/keycloak.dart';
import 'package:dayaway_partner/data/remote/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authDataSourceProvider =
    Provider(((ref) => AuthDataSource(ref.read(dioProvider))));

class AuthDataSource {
  final Dio _dio;

  AuthDataSource(this._dio);

  Future<KeyCloak> loginKeyClock(Map<String, dynamic> body) async {
    var result = await _dio.post(
      Constants.of().keycloakEndpoint + '/token',
      data: body,
      options: Options(
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );
    return KeyCloak.fromJson(result.data);
  }
}
