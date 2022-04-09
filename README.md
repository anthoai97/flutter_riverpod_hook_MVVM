# Flutter Architecture

Flutter Architecture is a project that introduces MVVM architecture and project structure approaches to developing Flutter apps.

## Documentation

- [Install Flutter](https://flutter.dev/get-started/)
- [Flutter documentation](https://flutter.dev/docs)

## Installation

  - Dart 2.14.4
  - Flutter 2.5.3

## Environment

<img height="520px" src="https://github.com/wasabeef/art/raw/master/flutter-architecture-blueprints/MVVM.jpg" align="right" />

**iOS**
- iOS 13+

**Android**
- Android 5.1+
    - minSdkVersion 22
- targetSdkVersion 30

## App architecture
- Base on [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) + [Repository](https://docs.microsoft.com/ja-jp/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-design)

## Code Style
- [flutter_lints](https://pub.dev/packages/flutter_lints)

## Assets, Fonts

**If added some assets or fonts**

- Use [FlutterGen](https://github.com/FlutterGen/flutter_gen/)

## Models

**If added some models for api results**

- Use [Freezed](https://pub.dev/packages/freezed)

## Localizations

**If added some localizations (i.g. edited [*.arb])**

- Use [Official Flutter localization package](https://docs.google.com/document/d/10e0saTfAv32OZLRmONy866vnaw0I2jwL8zukykpgWBc)

## Git Commit message style

- [Semantic Commit Messages](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716)

## Code collections

#### Project settings
|Working status|Category|Description|Codes|
|:---:|---|---|---|
| ✅ | Dart | Dart version | [pubspec.yaml] |
| ✅ | Dart | Switching between Development and Production environment | [constants.dart], [runConfigurations], [Makefile] |
| ✅ | Dart | Lint / Analyze | [analysis_options.yaml] |
| ✅ | Android | Kotlin version | [build.gradle] |
| ✅ | Android | Apk attributes | build.gradle ([compileSdkVersion], [applicationId], [minSdkVersion], [targetSdkVersion]) |
| ✅ | Android | Switching between Development and Production environment | [build.gradle], [Flavor dirs], [signingConfigs] |
| ✅ | iOS | Xcode version | [compatibilityVersion] |
| ✅ | iOS | Podfile | [Podfile] |
| ✅ | iOS | Switching between Development and Production environment | [xcconfig], [Podfile] |
| ✅ | [Firebase] | [Android] Switching between Development and Production google-service.json using flavors | [development and production] |
| ✅ | [Firebase] | [iOS] Switching between Development and Production GoogleService-Info.plist using run script| [copy_google_service.sh], [development and production] |
| ✅ | [Firebase Auth] | SignIn, SignOut | [auth_data_source_impl.dart] |
| ✅ | [Firebase Crashlytics] | Crash Reports | [main.dart] |
| ✅ | [Firebase Performance] | Network monitoring with [dio_firebase_performance] | [app_dio.dart]|

#### Architecture

|Working status|Category|Description|Codes|
|:---:|---|---|---|
| ✅ | Base | Using [Riverpod](https://pub.dev/packages/riverpod) + [Hooks](https://pub.dev/packages/flutter_hooks) + [ChangeNotifier](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple#changenotifier) + MVVM | [news_page.dart], [news_view_model.dart], [news_repository.dart], [news_data_source.dart] |
| ✅ | Networking | Using [dio](https://pub.dev/packages/dio) and [Retofit](https://pub.dev/packages/retrofit) | [app_dio.dart], [news_data_source.dart] |
| ✅ | Data | Using [Freezed](https://pub.dev/packages/freezed) | [model classes] |
| ✅ | Constants | Define constants and route names | [constants.dart] |
| ✅ | Localization | Switching between two languages with [Intl package] |
| ✅ | Error handling | Using Result pattern - A value that represents either a success or a failure, including an associated value in each case. | [result.dart], [news_repository_impl.dart], [home_page.dart] |

#### UI
|Working status|Category|Description|Codes|
|:---:|---|---|---|
| ✅ | Theme | Staticly Switch between light and dark themes | [app_theme.dart] |
| ✅ | Font | Using [Google font](https://pub.dev/packages/google_fonts) | [app_theme.dart] |
| ✅ | Transition | Simple animation between screens using [Hero](https://flutter.dev/docs/development/ui/animations/hero-animations) | [article_item.dart], [detail_page.dart] |

#### CI
|Working status|Category|Description|Codes|
|:---:|---|---|---|
| ✅ | Build | Using [Codemagic](https://codemagic.io/) |[codemagic.yaml] |

## Getting Started


### Setup

```shell script
$ make dependencies
$ make build-runner
```

### How to add assets(images..)
1. Add assets
2. Run [FlutterGen](https://github.com/fluttergen)

### How to add localizations
1. Edit [*.arb] files.
2. Run generate the `flutter pub get`

<br/>

### Make .apk and .ipa file

<img height="540px" src="https://github.com/wasabeef/art/raw/master/flutter-architecture-blueprints/running-app.gif" align="left" />

Android
```shell script
$ make build-android-dev
$ make build-android-prd
```

iOS
```shell script
$ make build-ios-dev
$ make build-ios-prd
```

### Run app
```shell script
$ make run-dev
$ make run-prd
```
## Special Thanks.

- [News API](https://newsapi.org/)

