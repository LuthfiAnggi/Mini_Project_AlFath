// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Inter-Italic.ttf
  String get interItalic => 'assets/fonts/Inter-Italic.ttf';

  /// File path: assets/fonts/Inter-SemiBold.ttf
  String get interSemiBold => 'assets/fonts/Inter-SemiBold.ttf';

  /// File path: assets/fonts/Inter-reguler.ttf
  String get interReguler => 'assets/fonts/Inter-reguler.ttf';

  /// List of all assets
  List<String> get values => [interItalic, interSemiBold, interReguler];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_arrow-left.png
  AssetGenImage get icArrowLeft =>
      const AssetGenImage('assets/icons/ic_arrow-left.png');

  /// File path: assets/icons/ic_building.png
  AssetGenImage get icBuilding =>
      const AssetGenImage('assets/icons/ic_building.png');

  /// File path: assets/icons/ic_close.png
  AssetGenImage get icClose => const AssetGenImage('assets/icons/ic_close.png');

  /// File path: assets/icons/ic_eye.png
  AssetGenImage get icEye => const AssetGenImage('assets/icons/ic_eye.png');

  /// File path: assets/icons/ic_filter.png
  AssetGenImage get icFilter =>
      const AssetGenImage('assets/icons/ic_filter.png');

  /// File path: assets/icons/ic_google.png
  AssetGenImage get icGoogle =>
      const AssetGenImage('assets/icons/ic_google.png');

  /// File path: assets/icons/ic_mail.png
  AssetGenImage get icMail => const AssetGenImage('assets/icons/ic_mail.png');

  /// File path: assets/icons/ic_reload.png
  AssetGenImage get icReload =>
      const AssetGenImage('assets/icons/ic_reload.png');

  /// File path: assets/icons/ic_search.png
  AssetGenImage get icSearch =>
      const AssetGenImage('assets/icons/ic_search.png');

  /// File path: assets/icons/ic_users.png
  AssetGenImage get icUsers => const AssetGenImage('assets/icons/ic_users.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    icArrowLeft,
    icBuilding,
    icClose,
    icEye,
    icFilter,
    icGoogle,
    icMail,
    icReload,
    icSearch,
    icUsers,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/img_Indonesia.png
  AssetGenImage get imgIndonesia =>
      const AssetGenImage('assets/images/img_Indonesia.png');

  /// File path: assets/images/img__Illustration1.png
  AssetGenImage get imgIllustration1 =>
      const AssetGenImage('assets/images/img__Illustration1.png');

  /// File path: assets/images/img__Illustration2.png
  AssetGenImage get imgIllustration2 =>
      const AssetGenImage('assets/images/img__Illustration2.png');

  /// File path: assets/images/img__Illustration3.png
  AssetGenImage get imgIllustration3 =>
      const AssetGenImage('assets/images/img__Illustration3.png');

  /// File path: assets/images/img__Illustration4.png
  AssetGenImage get imgIllustration4 =>
      const AssetGenImage('assets/images/img__Illustration4.png');

  /// File path: assets/images/img_bg_Onboarding.png
  AssetGenImage get imgBgOnboarding =>
      const AssetGenImage('assets/images/img_bg_Onboarding.png');

  /// File path: assets/images/img_erorr_404.png
  AssetGenImage get imgErorr404 =>
      const AssetGenImage('assets/images/img_erorr_404.png');

  /// File path: assets/images/img_erorr_504.png
  AssetGenImage get imgErorr504 =>
      const AssetGenImage('assets/images/img_erorr_504.png');

  /// File path: assets/images/img_erorr_connection.png
  AssetGenImage get imgErorrConnection =>
      const AssetGenImage('assets/images/img_erorr_connection.png');

  /// File path: assets/images/img_login.png
  AssetGenImage get imgLogin =>
      const AssetGenImage('assets/images/img_login.png');

  /// File path: assets/images/img_logo_light.png
  AssetGenImage get imgLogoLight =>
      const AssetGenImage('assets/images/img_logo_light.png');

  /// File path: assets/images/img_profile.png
  AssetGenImage get imgProfile =>
      const AssetGenImage('assets/images/img_profile.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    imgIndonesia,
    imgIllustration1,
    imgIllustration2,
    imgIllustration3,
    imgIllustration4,
    imgBgOnboarding,
    imgErorr404,
    imgErorr504,
    imgErorrConnection,
    imgLogin,
    imgLogoLight,
    imgProfile,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
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
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
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
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
