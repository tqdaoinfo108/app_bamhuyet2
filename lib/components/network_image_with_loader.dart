import 'package:app_bamnguyet_2/components/skeleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/constants.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;

  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = defaultPadding,
  });

  final String src;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: "http://hoanglambamhuyet.gvbsoft.com/$src",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        placeholder: (context, url) => Center(
          child: SizedBox(
              width: 30,
              height: 30,
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: primaryColor, size: 20)),
        ),
        errorWidget: (context, url, error) =>
            Image.asset("assets/images/customer-service.png"),
      ),
    );
  }
}

class NetworkImageWithLoaderAndRadiusBorder extends StatelessWidget {
  final BoxFit fit;

  const NetworkImageWithLoaderAndRadiusBorder(this.src,
      {super.key,
      this.fit = BoxFit.cover,
      required this.radius,
      this.imageError = "assets/images/massage.png"});
  final String imageError;
  final String src;
  final BorderRadiusGeometry radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: "http://hoanglambamhuyet.gvbsoft.com/$src",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        placeholder: (context, url) => const Skeleton(),
        errorWidget: (context, url, error) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imageError),
        ),
      ),
    );
  }
}
