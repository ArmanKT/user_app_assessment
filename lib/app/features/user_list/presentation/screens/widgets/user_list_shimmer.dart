import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:user_app_assessment/app/core/utils/app_colors.dart';
import 'package:user_app_assessment/app/core/utils/dimensions.dart';

class UserCardShimmer extends StatelessWidget {
  const UserCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          leading: Bone.circle(
            size: Dimensions.avatar,
          ),
          title: Bone.text(),
          subtitle: Bone.text(),
        ),
      ),
    );
  }
}

class UserListShimmer extends StatelessWidget {
  final int itemCount;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsetsGeometry? padding;
  const UserListShimmer({super.key, this.itemCount = 10, this.scrollPhysics, this.padding});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: scrollPhysics,
      padding: padding ?? EdgeInsets.symmetric(vertical: Dimensions.padding),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: Dimensions.paddingExtraSmall),
      itemBuilder: (context, index) {
        return UserCardShimmer();
      },
    );
  }
}
