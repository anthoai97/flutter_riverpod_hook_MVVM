# dayaway_partner

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Getting Started
This project using redux, nvvm, 

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