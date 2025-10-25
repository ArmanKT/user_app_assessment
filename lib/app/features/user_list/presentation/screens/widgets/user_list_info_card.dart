import 'package:flutter/material.dart';
import 'package:user_app_assessment/app/components/image/my_network_image_widget.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/app/features/user_list/data/models/user_model.dart';

class UseListInfoCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const UseListInfoCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        onTap: onTap,
        leading: Hero(
          tag: 'user_${user.id}',
          child: MyNetworkImageWidget(
            imageUrl: user.avatar,
            width: Dimensions.avatar,
            height: Dimensions.avatar,
            radius: Dimensions.radiusMax,
            isProfile: true,
          ),
        ),
        title: Text(
          user.fullName,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          user.email,
          style: context.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
