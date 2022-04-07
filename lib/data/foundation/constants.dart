import 'package:enum_to_string/enum_to_string.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum Flavor { development, production }

abstract class SharePreferenceKey {
  static const String theme = 'theme';
  static const String authToken = "authToken";
  static const String refreshToken = "refreshToken";
}

@immutable
class Constants {
  const Constants._({
    required this.endpoint,
    required this.env,
    required this.packageName,
    required this.keycloakEndpoint,
  });

  factory Constants.of() {
    final flavor = EnumToString.fromString(
      Flavor.values,
      const String.fromEnvironment("FLAVOR"),
    );

    switch (flavor) {
      case Flavor.development:
        return Constants._dev();
      case Flavor.production:
        return Constants._prd();
      default:
        return Constants._dev();
    }
  }

  factory Constants._dev() {
    return const Constants._(
      endpoint: 'https://dawsvc-hotelier-dev.dayaway.sg/graphql',
      env: Flavor.development,
      packageName: "com.hcg.dayawaypartner.dev",
      keycloakEndpoint:
          'https://identity-dev.dayaway.sg/auth/realms/dayaway-hotelier/protocol/openid-connect',
    );
  }

  factory Constants._prd() {
    return const Constants._(
      endpoint: 'https://dawsvc-hotelier-qa.dayaway.sg/graphql',
      env: Flavor.production,
      packageName: "com.hcg.dayawaypartner",
      keycloakEndpoint:
          'https://identity-qa.dayaway.sg/auth/realms/dayaway-hotelier/protocol/openid-connect',
    );
  }

  static late final Constants instance = Constants.of();

  final String endpoint;
  final Flavor env;
  final String packageName;

  final String clientId = 'dayaway-hotelier-site';
  final String keycloakEndpoint;
}
