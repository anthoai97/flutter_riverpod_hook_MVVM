import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dayaway_partner/data/foundation/extentions/extention.dart';
import 'package:dayaway_partner/ui/component/nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:dayaway_partner/ui/hook/use_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class AppImageCacheManager {
  static const bool enableCache = true;
  static const bool enableMemCache = false;
  static const int width = 600;
  static const int height = 400;
}

class ImgView {
  //
  static Widget load(
    String src, {
    Key? key,
    String? srcPlaceHolder,
    Color? placeHolderColor,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double scale = 1.0,
    double? width,
    double? height,
    Color? color,
    Color? backgroundColor,
    BlendMode colorBlendMode = BlendMode.srcIn,
    BoxFit fit = BoxFit.fill,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Map<String, String>? headers,
    String? package,
    AssetBundle? bundle,
    double? ratio,
    bool isTryBuildErrorHolder = true,
    ImageWidgetBuilder? imageBuilder,
    PlaceholderWidgetBuilder? placeholder,
    ProgressIndicatorBuilder? progressIndicatorBuilder,
    LoadingErrorWidgetBuilder? errorWidget,
    Duration? placeholderFadeInDuration,
    Duration fadeOutDuration = const Duration(milliseconds: 1000),
    Curve fadeOutCurve = Curves.easeOut,
    Duration fadeInDuration = const Duration(milliseconds: 500),
    Curve fadeInCurve = Curves.easeIn,
    bool? useOldImageOnUrlChange,
    bool cache = AppImageCacheManager.enableCache,
    bool memCache = AppImageCacheManager.enableMemCache,
    EdgeInsets? padding,
    EdgeInsets? innerPadding,
    EdgeInsets? margin,
    Widget? loadingComponent,
  }) {
    Widget view() {
      try {
        if (src.isNetwork) {
          return network(
            src,
            key: key,
            frameBuilder: frameBuilder,
            errorBuilder: errorBuilder,
            semanticLabel: semanticLabel,
            excludeFromSemantics: excludeFromSemantics,
            scale: scale,
            width: width,
            height: height,
            color: color,
            srcPlaceHolder: srcPlaceHolder,
            placeHolderColor: placeHolderColor,
            colorBlendMode: colorBlendMode,
            fit: fit,
            alignment: alignment,
            repeat: repeat,
            centerSlice: centerSlice,
            matchTextDirection: matchTextDirection,
            gaplessPlayback: gaplessPlayback,
            isAntiAlias: isAntiAlias,
            headers: headers,
            filterQuality: filterQuality,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            ratio: ratio,
            imageBuilder: imageBuilder,
            allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
            cache: cache,
            memCache: memCache,
            errorWidget: errorWidget,
            placeholderBuilder: placeholderBuilder,
            isTryBuildErrorHolder: isTryBuildErrorHolder,
            useOldImageOnUrlChange: useOldImageOnUrlChange,
            fadeInCurve: fadeInCurve,
            fadeInDuration: fadeInDuration,
            fadeOutCurve: fadeOutCurve,
            fadeOutDuration: fadeOutDuration,
            progressIndicatorBuilder: progressIndicatorBuilder,
            placeholderFadeInDuration: placeholderFadeInDuration,
            placeholder: placeholder,
            padding: innerPadding,
            loadingComponent: loadingComponent,
          );
        } else if (src.isAsset) {
          return asset(
            src,
            key: key,
            bundle: bundle,
            frameBuilder: frameBuilder,
            errorBuilder: errorBuilder,
            semanticLabel: semanticLabel,
            excludeFromSemantics: excludeFromSemantics,
            scale: scale,
            width: width,
            srcPlaceHolder: srcPlaceHolder,
            placeHolderColor: placeHolderColor,
            height: height,
            color: color,
            colorBlendMode: colorBlendMode,
            fit: fit,
            alignment: alignment,
            repeat: repeat,
            centerSlice: centerSlice,
            matchTextDirection: matchTextDirection,
            gaplessPlayback: gaplessPlayback,
            isAntiAlias: isAntiAlias,
            package: package,
            filterQuality: filterQuality,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            ratio: ratio,
            padding: innerPadding,
          );
        } else {
          return file(
            File(src),
            key: key,
            frameBuilder: frameBuilder,
            errorBuilder: errorBuilder,
            semanticLabel: semanticLabel,
            excludeFromSemantics: excludeFromSemantics,
            scale: scale,
            width: width,
            height: height,
            srcPlaceHolder: srcPlaceHolder,
            placeHolderColor: placeHolderColor,
            color: color,
            colorBlendMode: colorBlendMode,
            fit: fit,
            alignment: alignment,
            repeat: repeat,
            centerSlice: centerSlice,
            matchTextDirection: matchTextDirection,
            gaplessPlayback: gaplessPlayback,
            isAntiAlias: isAntiAlias,
            filterQuality: filterQuality,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            ratio: ratio,
            padding: innerPadding,
          );
        }
      } catch (e) {
        if (isTryBuildErrorHolder) {
          return defaultImageHolder(
            src: srcPlaceHolder,
            placeHolderColor: placeHolderColor,
            width: width,
            height: height,
          );
        }
        return Container(
          width: width,
          height: height,
          color: backgroundColor,
        );
      }
    }

    Widget viewRatio() {
      if (null != ratio && ratio > 0) {
        return AspectRatio(
          aspectRatio: 1 / ratio,
          child: view(),
        );
      }
      return view();
    }

    if (null != padding || null != margin) {
      return Container(
        padding: padding,
        margin: margin,
        child: viewRatio(),
      );
    }
    return viewRatio();
  }

  static Widget asset(
    String src, {
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Color? backgroundColor,
    BlendMode colorBlendMode = BlendMode.srcIn,
    BoxFit fit = BoxFit.fill,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? srcPlaceHolder,
    Color? placeHolderColor,
    bool isTryBuildErrorHolder = true,
    double? ratio,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) {
    Widget view() {
      try {
        if (null == height && null != ratio) {
          width ??= useDimension().screenWidth;
          height = width! * ratio;
        }
        if (src.endsWith('svg')) {
          return SvgPicture.asset(
            src,
            key: key,
            matchTextDirection: matchTextDirection,
            bundle: bundle,
            package: package,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
            allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
            placeholderBuilder: placeholderBuilder ??
                (BuildContext context) => defaultImageHolder(
                      src: srcPlaceHolder,
                      width: width,
                      height: height,
                      placeHolderColor: placeHolderColor,
                    ),
            color: color,
            colorBlendMode: colorBlendMode,
            semanticsLabel: semanticLabel,
            excludeFromSemantics: excludeFromSemantics,
          );
        }

        return Image.asset(
          src,
          key: key,
          bundle: bundle,
          frameBuilder: frameBuilder,
          errorBuilder: errorBuilder ??
              (BuildContext context, Object error, StackTrace? stackTrace) =>
                  defaultImageHolder(
                    src: srcPlaceHolder,
                    placeHolderColor: placeHolderColor,
                    width: width,
                    height: height,
                  ),
          semanticLabel: semanticLabel,
          excludeFromSemantics: excludeFromSemantics,
          scale: scale,
          width: width,
          height: height,
          color: color,
          colorBlendMode: colorBlendMode,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          centerSlice: centerSlice,
          matchTextDirection: matchTextDirection,
          gaplessPlayback: gaplessPlayback,
          isAntiAlias: isAntiAlias,
          package: package,
          filterQuality: filterQuality,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
        );
      } catch (e) {
        if (isTryBuildErrorHolder) {
          return defaultImageHolder(
            src: srcPlaceHolder,
            placeHolderColor: placeHolderColor,
            width: width,
            height: height,
          );
        }
        return Container(
          width: width,
          height: height,
          color: backgroundColor,
        );
      }
    }

    Widget viewRatio() {
      if (null != ratio && ratio > 0) {
        return AspectRatio(
          aspectRatio: 1 / ratio,
          child: view(),
        );
      }
      return view();
    }

    if (null != padding || null != margin) {
      return Container(
        padding: padding,
        margin: margin,
        child: viewRatio(),
      );
    }
    return viewRatio();
  }

  static Widget network(
    String src, {
    Key? key,
    String? srcPlaceHolder,
    Color? placeHolderColor,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double scale = 1.0,
    double? width,
    double? height,
    Color? color,
    Color? backgroundColor,
    BlendMode colorBlendMode = BlendMode.srcIn,
    BoxFit fit = BoxFit.fill,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Map<String, String>? headers,
    bool isTryBuildErrorHolder = true,
    double? ratio,
    ImageWidgetBuilder? imageBuilder,
    PlaceholderWidgetBuilder? placeholder,
    ProgressIndicatorBuilder? progressIndicatorBuilder,
    LoadingErrorWidgetBuilder? errorWidget,
    Duration? placeholderFadeInDuration,
    Duration fadeOutDuration = const Duration(milliseconds: 0),
    Curve fadeOutCurve = Curves.linearToEaseOut,
    Duration fadeInDuration = const Duration(milliseconds: 0),
    Curve fadeInCurve = Curves.linear,
    bool? useOldImageOnUrlChange,
    bool cache = AppImageCacheManager.enableCache,
    bool memCache = AppImageCacheManager.enableMemCache,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Widget? loadingComponent,
  }) {
    Widget view() {
      try {
        if (src.endsWith('svg')) {
          return SvgPicture.network(src,
              key: key,
              matchTextDirection: matchTextDirection,
              width: width,
              height: height,
              headers: headers,
              fit: fit,
              alignment: alignment,
              allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
              placeholderBuilder: placeholderBuilder ??
                  (BuildContext context) => defaultImageHolder(
                        src: srcPlaceHolder,
                        placeHolderColor: placeHolderColor,
                        width: width,
                        height: height,
                        loadingComponent: loadingComponent,
                      ),
              color: color,
              colorBlendMode: colorBlendMode,
              semanticsLabel: semanticLabel,
              excludeFromSemantics: excludeFromSemantics);
        }
        if (cache) {
          return CachedNetworkImage(
            key: key,
            fadeInCurve: fadeInCurve,
            fadeInDuration: fadeInDuration,
            fadeOutCurve: fadeOutCurve,
            fadeOutDuration: fadeOutDuration,
            progressIndicatorBuilder: progressIndicatorBuilder,
            placeholderFadeInDuration: placeholderFadeInDuration,
            placeholder: placeholder ??
                (BuildContext context, String url) => defaultImageHolder(
                      src: srcPlaceHolder,
                      placeHolderColor: placeHolderColor,
                      width: width,
                      height: height,
                      loadingComponent: loadingComponent,
                    ),
            imageUrl: src,
            imageBuilder: imageBuilder,
            errorWidget: errorWidget ??
                (BuildContext context, String url, dynamic error) =>
                    defaultImageHolder(
                      src: srcPlaceHolder,
                      placeHolderColor: placeHolderColor,
                      width: width,
                      height: height,
                    ),
            width: width,
            height: height,
            color: color,
            colorBlendMode: colorBlendMode,
            fit: fit,
            alignment: alignment,
            repeat: repeat,
            matchTextDirection: matchTextDirection,
            httpHeaders: headers,
            filterQuality: filterQuality,
            memCacheWidth:
                memCache ? cacheWidth ?? AppImageCacheManager.width : null,
            memCacheHeight:
                memCache ? cacheHeight ?? AppImageCacheManager.height : null,
          );
        }
        return Image.network(
          src,
          key: key,
          frameBuilder: frameBuilder,
          errorBuilder: errorBuilder ??
              (BuildContext context, Object error, StackTrace? stackTrace) =>
                  defaultImageHolder(
                    src: srcPlaceHolder,
                    placeHolderColor: placeHolderColor,
                    width: width,
                    height: height,
                  ),
          semanticLabel: semanticLabel,
          excludeFromSemantics: excludeFromSemantics,
          scale: scale,
          width: width,
          height: height,
          color: color,
          colorBlendMode: colorBlendMode,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          centerSlice: centerSlice,
          matchTextDirection: matchTextDirection,
          gaplessPlayback: gaplessPlayback,
          isAntiAlias: isAntiAlias,
          headers: headers,
          filterQuality: filterQuality,
          cacheWidth:
              memCache ? cacheWidth ?? AppImageCacheManager.width : null,
          cacheHeight:
              memCache ? cacheHeight ?? AppImageCacheManager.height : null,
        );
      } catch (e) {
        if (isTryBuildErrorHolder) {
          return defaultImageHolder(
            src: srcPlaceHolder,
            placeHolderColor: placeHolderColor,
            width: width,
            height: height,
          );
        }
        return Container(
          width: width,
          height: height,
          color: backgroundColor,
        );
      }
    }

    Widget viewRatio() {
      if (null != ratio && ratio > 0) {
        return AspectRatio(
          aspectRatio: 1 / ratio,
          child: view(),
        );
      }
      return view();
    }

    if (null != padding || null != margin) {
      return Container(padding: padding, margin: margin, child: viewRatio());
    }

    return viewRatio();
  }

  static Widget file(
    File file, {
    Key? key,
    String? srcPlaceHolder,
    Color? placeHolderColor,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Color? backgroundColor,
    BlendMode colorBlendMode = BlendMode.srcIn,
    BoxFit fit = BoxFit.fill,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    bool isTryBuildErrorHolder = true,
    double? ratio,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) {
    Widget view() {
      try {
        if (file.path.endsWith('svg')) {
          return SvgPicture.file(file,
              key: key,
              matchTextDirection: matchTextDirection,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
              placeholderBuilder: placeholderBuilder ??
                  (BuildContext context) => defaultImageHolder(
                        src: srcPlaceHolder,
                        placeHolderColor: placeHolderColor,
                        width: width,
                        height: height,
                      ),
              color: color,
              colorBlendMode: colorBlendMode,
              semanticsLabel: semanticLabel,
              excludeFromSemantics: excludeFromSemantics);
        }
        return Image.file(
          file,
          key: key,
          frameBuilder: frameBuilder,
          errorBuilder: errorBuilder ??
              (BuildContext context, Object error, StackTrace? stackTrace) =>
                  defaultImageHolder(
                    src: srcPlaceHolder,
                    placeHolderColor: placeHolderColor,
                    width: width,
                    height: height,
                  ),
          semanticLabel: semanticLabel,
          excludeFromSemantics: excludeFromSemantics,
          scale: scale ?? 1.0,
          width: width,
          height: height,
          color: color,
          colorBlendMode: colorBlendMode,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          centerSlice: centerSlice,
          matchTextDirection: matchTextDirection,
          gaplessPlayback: gaplessPlayback,
          isAntiAlias: isAntiAlias,
          filterQuality: filterQuality,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
        );
      } catch (e) {
        if (isTryBuildErrorHolder) {
          return defaultImageHolder(
            src: srcPlaceHolder,
            placeHolderColor: placeHolderColor,
            width: width,
            height: height,
          );
        }
        return Container(
          width: width,
          height: height,
          color: backgroundColor,
        );
      }
    }

    Widget viewRatio() {
      if (null != ratio && ratio > 0) {
        return AspectRatio(
          aspectRatio: 1 / ratio,
          child: view(),
        );
      }
      return view();
    }

    if (null != padding || null != margin) {
      return Container(padding: padding, margin: margin, child: viewRatio());
    }
    return viewRatio();
  }

  static Widget defaultImageHolder({
    String? src,
    Color? placeHolderColor,
    double? width,
    double? height,
    Widget? loadingComponent = const NutsActivityIndicator(radius: 8.0),
  }) {
    Widget view() {
      if (src.isTextNotEmpty) {
        try {
          if (src!.endsWith('svg')) {
            return SvgPicture.asset(
              src,
              width: width,
              height: height,
              fit: BoxFit.fill,
            );
          } else if (src.isNetwork) {
            return CachedNetworkImage(
              imageUrl: src,
              width: width,
              height: height,
              fit: BoxFit.fill,
            );
          } else {
            return Image.asset(
              src,
              width: width,
              height: height,
              fit: BoxFit.fill,
            );
          }
        } catch (e) {
          return Container(
            width: width,
            height: height,
            color: placeHolderColor,
          );
        }
      }

      return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: const NutsActivityIndicator(radius: 8.0),
        color: placeHolderColor ??
            (src == null ? Colors.grey.withOpacity(0.6) : Colors.white),
      );
    }

    Widget loadingView() {
      if (null != loadingComponent) {
        return Stack(
          alignment: Alignment.center,
          children: [
            view(),
            loadingComponent,
          ],
        );
      }
      return view();
    }

    return loadingView();
  }
//
}
