import 'dart:io';
import 'dart:ui';

import 'package:code_running_front/utils/enum.dart';
import 'package:flutter/material.dart';

class ImageLoadView extends StatelessWidget {
  /// 图片URL
  final String path;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 填充效果
  final BoxFit fit;

  /// 加载中图片
  final String placeholder;

  /// 圆角
  final BorderRadius borderRadius;

  ///
  final ImageType imageType;

  /// 透明度
  final double opacity;

  final double sigmaX;
  final double sigmaY;

  /// 过滤颜色
  final Color filterColor;

  final Widget child;

  /// 子控件位置
  final AlignmentGeometry alignment;

  ImageLoadView(
    this.path, {
    Key key,
    this.width,
    this.height,
    this.fit: BoxFit.fill,
    this.borderRadius: const BorderRadius.all(Radius.circular(0.0)),
    this.placeholder: "images/placeholders/dog_loading.gif",
    this.imageType: ImageType.network,
    this.opacity: 1.0,
    this.sigmaX: 0.0,
    this.sigmaY: 0.0,
    this.filterColor: Colors.transparent,
    this.child: const SizedBox(),
    this.alignment: Alignment.center,
  })  : assert(path != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
        imageWidget = FadeInImage(
            placeholder: AssetImage(placeholder),
            image: NetworkImage(path),
            fit: fit);
        break;
      case ImageType.assets:
        imageWidget = FadeInImage(
            placeholder: AssetImage(placeholder),
            image: AssetImage(path),
            fit: fit);
        break;
      case ImageType.localFile:
        imageWidget = FadeInImage(
            placeholder: AssetImage(placeholder),
            image: FileImage(File(path)),
            fit: fit);
        break;
      default:
        imageWidget = Image.asset(placeholder);
        break;
    }

    return GestureDetector(
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              imageWidget,
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    color: filterColor,
                    child: child,
                    alignment: alignment,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
