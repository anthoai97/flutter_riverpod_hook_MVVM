import 'package:enum_to_string/enum_to_string.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum Flavor { development, production }

abstract class SharePreferenceKey {
  static const String theme = 'theme';
}

@immutable
class Constants {
  const Constants._({
    required this.apiKey,
    required this.endpoint,
    required this.env,
    required this.packageName,
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
      default:
        return Constants._prd();
    }
  }

  factory Constants._dev() {
    return const Constants._(
        endpoint: 'https://newsapi.org',
        apiKey: '34f77f43f30d47839498d87d84d05860',
        env: Flavor.development,
        packageName: "vn.anquach.app");
  }

  factory Constants._prd() {
    return const Constants._(
        endpoint: 'https://newsapi.org',
        apiKey: '34f77f43f30d47839498d87d84d05860',
        env: Flavor.production,
        packageName: "vn.anquach.app");
  }

  static late final Constants instance = Constants.of();

  final String endpoint;
  final String apiKey;
  final Flavor env;
  final String packageName;

  final String dynamicLinkUrlPrefix = "https://anquach.page.link";
}
