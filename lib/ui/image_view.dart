import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/**
 * Author: Kingtous
 * Since: 2020-01-17
 * Email: me@kingtous.cn
 */
class ImageZoomView extends StatelessWidget {
  final String url;

  ImageZoomView(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.black),
            child: PhotoView(imageProvider: NetworkImage(url))),
      ),
    );
  }
}
