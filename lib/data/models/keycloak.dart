import 'package:freezed_annotation/freezed_annotation.dart';

part 'keycloak.freezed.dart';
part 'keycloak.g.dart';

@freezed
class KeyCloak with _$KeyCloak {
  factory KeyCloak({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'expires_in') int? expiresIn,
    @JsonKey(name: 'refresh_expires_in') int? refreshExpiresIn,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    String? tokenType,
    String? sessionState,
  }) = _KeyCloak;

  factory KeyCloak.fromJson(Map<String, dynamic> json) =>
      _$KeyCloakFromJson(json);
}
