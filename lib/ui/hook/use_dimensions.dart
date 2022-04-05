import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScreenUtils useDimension() {
  final context = useContext();
  return ScreenUtils.of(context);
}

class ScreenUtils {
  ScreenUtils._({
    required this.pixelRatio,
    required this.screenWidth,
    required this.screenHeight,
    required this.statusBarHeight,
    required this.bottomBarHeight,
  });

  final double pixelRatio;
  final double screenWidth;
  final double screenHeight;
  final double statusBarHeight;
  final double bottomBarHeight;

  factory ScreenUtils.of(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final pixelRatio = mediaQuery.devicePixelRatio;
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final statusBarHeight = mediaQuery.padding.top;
    final bottomBarHeight = mediaQuery.padding.bottom;

    return ScreenUtils._(
      pixelRatio: pixelRatio,
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      statusBarHeight: statusBarHeight,
      bottomBarHeight: bottomBarHeight,
    );
  }
}
