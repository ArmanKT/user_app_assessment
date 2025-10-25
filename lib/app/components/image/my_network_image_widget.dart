import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:user_app_assessment/app/components/image/random_color_avatar.dart';
import '../../core/utils/utils_exporter.dart';

class MyNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final String? imageAlt;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit boxFit;
  final bool isProfile;
  final Color? color;
  final bool isSvg;
  final Widget? customErrorWidget;

  const MyNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.imageAlt,
    this.height = 100,
    this.width = 100,
    this.radius = Dimensions.radiusSmall,
    this.boxFit = BoxFit.cover,
    this.isProfile = false,
    this.customErrorWidget,
    this.isSvg = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _buildErrorWidget();
    }

    return _buildCachedImage();
  }

  Widget _buildCachedImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      color: color,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
            colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          ),
        ),
      ),
      placeholder: (context, url) => _buildPlaceholderWidget(),
      errorWidget: (context, url, error) => _buildErrorWidget(),
    );
  }

  Widget _buildPlaceholderWidget() {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Center(
          child: SpinKitFadingCube(
            color: AppColors.primary.withValues(alpha: 0.3),
            size: Dimensions.iconLarge,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return SizedBox(
      height: height,
      width: width,
      child: FittedBox(
        fit: boxFit,
        child: isProfile
            ? (imageAlt != null && imageAlt!.isNotEmpty
                ? RandomColorAvatar(
                    width: Dimensions.avatarSmall,
                    height: Dimensions.avatarSmall,
                    name: imageAlt!,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: Center(
                      child: Skeleton.replace(
                        replace: true,
                        replacement: Bone.circle(
                          size: (height ?? 20) / 2,
                        ),
                        child: Icon(
                          Icons.image,
                          color: AppColors.primary.withValues(alpha: 0.3),
                          size: (height ?? 20) / 2,
                        ),
                      ),
                    ),
                  ))
            : customErrorWidget ??
                ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: Center(
                    child: Skeleton.replace(
                      replace: true,
                      replacement: Bone.circle(
                        size: (height ?? 20) / 2,
                      ),
                      child: Icon(
                        Icons.image,
                        color: AppColors.primary.withValues(alpha: 0.3),
                        size: (height ?? 20) / 2,
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
