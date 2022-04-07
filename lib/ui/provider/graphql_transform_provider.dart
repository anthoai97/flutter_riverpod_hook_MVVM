import 'dart:convert';

import 'package:dayaway_partner/data/foundation/constants.dart';
import 'package:dayaway_partner/data/foundation/log.dart';
import 'package:dayaway_partner/data/models/base_response.dart';
import 'package:dayaway_partner/ui/provider/api_service_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final graphQLTransformerProviler =
    Provider((ref) => GraphQLTransformer(ref.read));

class GraphQLTransformer {
  late final ApiService _apiService = _reader(apiServiceProvider);

  final Reader _reader;

  GraphQLTransformer(this._reader);

  Future<DayAwayResponse> query(
    String document, {
    Map<String, dynamic>? filter,
    bool useToken = false,
  }) async {
    Log.debug(document, title: "Query document");
    Log.debug(filter, title: "Query filter");

    var body = {
      'query': document,
      'variables': {
        "filter": filter,
      }
    };

    var response = await _apiService.post(Constants.of().endpoint,
        body: json.encode(body));

    // _authMiddileware(response);

    return response;
  }

  Future<DayAwayResponse> mutation(
    String document, {
    Map<String, dynamic>? input,
    bool useToken = false,
  }) async {
    Log.debug(document, title: "Mutate document");
    Log.debug(input, title: "Mutate input");

    var body = {
      'query': document,
      'variables': {
        "input": input,
      }
    };

    var response = await _apiService.post(Constants.of().endpoint,
        body: json.encode(body));

    // _authMiddileware(response);

    return response;
  }

  // void _authMiddileware(DayAwayResponse response) {
  //   if (response.message == "NotFoundException" ||
  //       response.message == "UnauthorisedException") {
  //     // Helper.logout();
  //   }
  // }
}
