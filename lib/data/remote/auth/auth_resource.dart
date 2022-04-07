import 'package:dayaway_partner/data/foundation/constants.dart';
import 'package:dayaway_partner/data/models/base_response.dart';
import 'package:dayaway_partner/ui/provider/api_service_provider.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authDataSourceProvider =
    Provider(((ref) => AuthDataSource(ref.read(apiServiceProvider))));

class AuthDataSource {
  final ApiService _apiService;

  AuthDataSource(this._apiService);

  Future<DayAwayResponse> loginKeyClock(Map<String, dynamic> body) async {
    return _apiService.post(Constants.of().keycloakEndpoint + '/token',
        body: body,
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}));
  }
}
