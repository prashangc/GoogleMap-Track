import 'package:blog/config/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyCachedNetworkImage extends StatelessWidget {
  final double myWidth;
  final double myHeight;
  final String myImage;

  const MyCachedNetworkImage({
    super.key,
    required this.myWidth,
    required this.myHeight,
    required this.myImage,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        width: myWidth,
        height: myHeight,
        imageUrl: myImage,
        imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  alignment: FractionalOffset.topCenter,
                ),
              ),
            ),
        placeholder: (context, url) => Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircularProgressIndicator(
                  color: AppColors.kPrimary,
                  strokeWidth: 1.5,
                  backgroundColor: AppColors.kWhite,
                ),
              ),
            ),
        errorWidget: (context, url, error) => const Icon(Icons.error_outline));
  }
}
