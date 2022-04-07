import 'package:dayaway_partner/data/local/shared_pref_service.dart';
import 'package:dayaway_partner/data/models/base_response.dart';
import 'package:dayaway_partner/data/remote/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/*  For update FormData // need http_parser package.
   var _formData = FormData.fromMap({
      'name-(whatever backend want)': await MultipartFile.fromFile(file.path, contentType: MediaType.parse("image/png")),
    });
    ApiService.post(url, _formData);
 */

final apiServiceProvider = Provider((ref) =>
    ApiService(NetWorkModule.provideDio(ref.read(sharedPrefServiceProvider))));

class ApiService {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  ApiService(this._dio);

  // Post:----------------------------------------------------------------------
  Future<DayAwayResponse> post(
    String url, {
    dynamic body,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    // try {
    Response response = await _dio.post(
      url,
      data: body,
      queryParameters: params,
      options: options,
    );
    return _handleResponse(response);
  }

  _handleResponse(Response? response) {
    if (response != null && response.statusCode == 200) {
      if (response.data['data'] != null) {
        return DayAwayResponse.fromJson(response.data['data']['response']);
      } else {
        return DayAwayResponse(data: response.data);
      }
    } else {
      throw Exception("UNNKOW ERRROR");
    }
  }

  //
}
