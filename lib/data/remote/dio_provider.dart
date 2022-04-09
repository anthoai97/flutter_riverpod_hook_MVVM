import 'dart:convert';

import 'package:dayaway_partner/data/foundation/constants.dart';
import 'package:dayaway_partner/data/foundation/extentions/extention.dart';
import 'package:dayaway_partner/data/foundation/log.dart';
import 'package:dayaway_partner/data/local/shared_pref_service.dart';
import 'package:dayaway_partner/data/models/keycloak.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider(
    (ref) => NetWorkModule.provideDio(ref.read(sharedPrefServiceProvider)));

abstract class NetWorkModule {
  static Dio provideDio(SharedPreferencesService _sharePef) {
    Dio dio;

    var options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000, //60 secs
      receiveTimeout: 30 * 1000,
      baseUrl: Constants.of().endpoint,
    );

    dio = Dio(options);

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          if (_sharePef.authToken != null) {
            options.headers
                .addAll({'Authorization': "Bearer " + _sharePef.authToken!});
          }

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          Log.debug('${response.data}', title: 'onResponse');

          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          Log.error(e, error: 'onError');
          if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
            try {
              final url = Constants.of().keycloakEndpoint + '/token';
              final params = {
                'grant_type': 'refresh_token',
                'client_secret': Constants.of().clientId,
                'refresh_token': Constants.of().clientId,
                'client_id': Constants.of().clientId,
              };

              Log.debug('Handle request refresh token',
                  title: 'onAuthenticate');

              final Dio dioRefresh = Dio(
                BaseOptions(
                  headers: <String, String>{
                    "content-type": 'application/x-www-form-urlencoded',
                  },
                ),
              );

              var tokenResponse = await dioRefresh.post(url, data: params);

              if (tokenResponse.statusCode == 200) {
                Map<String, dynamic> convertedData =
                    json.decode(tokenResponse.data);
                KeyCloak tokenData = KeyCloak.fromJson(convertedData);
                if (tokenData.accessToken.isTextNotEmpty &&
                    tokenData.refreshToken.isTextNotEmpty) {
                  _sharePef.saveAuthToken(tokenData.accessToken!);
                  _sharePef.saveRefreshToken(tokenData.refreshToken!);

                  e.requestOptions.headers["Authorization"] =
                      "Bearer " + tokenData.accessToken!;

                  //create request with new access token
                  final opts = Options(
                    method: e.requestOptions.method,
                    headers: e.requestOptions.headers,
                  );

                  final cloneReq = await dio.request(
                    e.requestOptions.path,
                    options: opts,
                    data: e.requestOptions.data,
                    queryParameters: e.requestOptions.queryParameters,
                  );

                  return handler.resolve(cloneReq);
                }
              }
            } on DioError catch (e) {
              handler.next(e);
            }
          } else {
            return handler.reject(e);
          }
        },
      ),
    );

    // Firebase Performance
    // dio.interceptors.add(DioFirebasePerformanceInterceptor());

    return dio;
  }
}
