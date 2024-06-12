import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    this.url,
    this.height = 100,
  });

  final String? url;
  final double height;

  @override
  Widget build(BuildContext context) {
    final placeHolderWidget = Image.asset(
      'assets/images/error_image.jpg',
      fit: BoxFit.cover,
      height: height,
      width: double.infinity,
    );
    return url != null
        ? CachedNetworkImage(
            imageUrl: url!,
            height: height,
            width: double.infinity,
            progressIndicatorBuilder: (context, _, __) {
              return const SizedBox();
            },
            errorWidget: (context, _, __) {
              return placeHolderWidget;
            },
            fit: BoxFit.cover,
          )
        : placeHolderWidget;
  }
}
