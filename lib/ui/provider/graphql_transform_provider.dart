import 'package:dayaway_partner/data/foundation/log.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final graphQLTransformerProviler = Provider((ref) => GraphQLTransformer());

class GraphQLTransformer {
  Map<String, dynamic> query(
    String document, {
    Map<String, dynamic>? filter,
  }) {
    Log.debug(document, title: "Query document");
    Log.debug(filter, title: "Query filter");

    return {
      'query': document,
      'variables': {
        "filter": filter,
      }
    };
  }

  // Future<DayAwayResponse> mutation(
  //   String document, {
  //   Map<String, dynamic>? input,
  // }) async {
  //   Log.debug(document, title: "Mutate document");
  //   Log.debug(input, title: "Mutate input");

  //   var body = {
  //     'query': document,
  //     'variables': {
  //       "input": input,
  //     }
  //   };

  //   var response = await _apiService.post(Constants.of().endpoint,
  //       body: json.encode(body));

  //   // _authMiddileware(response);

  //   return response;
  // }

  // void _authMiddileware(DayAwayResponse response) {
  //   if (response.message == "NotFoundException" ||
  //       response.message == "UnauthorisedException") {
  //     // Helper.logout();
  //   }
  // }
}
