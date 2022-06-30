import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../values/app_colors.dart';

class CircleAvatarBorder extends StatelessWidget {
  final String? avatarUrl;
  final double size;

  const CircleAvatarBorder({
    Key? key,
    this.avatarUrl,
    this.size = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        // border:
        // Border.all(color: colorBorder ?? Colors.white, width: widthBorder),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: CachedNetworkImage(
          imageUrl: avatarUrl!,
          errorWidget: (ctx, str, obj) => Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blueColor,
            ),
            child: Icon(
              Icons.person,
              size: size - 10,
              color: AppColors.likeColor,
            ),
          ),
        ),
      ),
    );
  }
}
