import 'package:flutter/material.dart';
import 'package:user_app_assessment/app/components/clippers/diagonal_clipper.dart';
import 'package:user_app_assessment/app/components/image/my_network_image_widget.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/app/features/user_list/data/models/user_model.dart';

class UserDetailPage extends StatelessWidget {
  final UserModel user;

  const UserDetailPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: DiagonalClipper(),
              child: Container(
                width: double.infinity,
                height: 320,
                color: context.primaryColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingLarge,
                    right: Dimensions.paddingLarge,
                    top: Dimensions.paddingLarge,
                    bottom: Dimensions.paddingLarge,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'user_${user.id}',
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                          ),
                          child: MyNetworkImageWidget(
                            imageUrl: user.avatar,
                            width: Dimensions.avatarHuge,
                            height: Dimensions.avatarHuge,
                            radius: Dimensions.radiusMax,
                            isProfile: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.padding),
                      Text(
                        user.fullName,
                        style: context.titleLarge.copyWith(
                          color: AppColors.surface,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.padding,
                ),
                child: Column(
                  children: [
                    // ID Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.padding,
                        vertical: Dimensions.paddingSmall,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.badge,
                            color: context.primaryColor,
                            size: Dimensions.iconSmall,
                          ),
                          const SizedBox(width: Dimensions.paddingSmall),
                          Text(
                            '${AppStrings.userID}: #${user.id}',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingLarge),
                    _buildInfoTile(
                      icon: Icons.person,
                      title: AppStrings.fullName,
                      value: user.fullName,
                      context: context,
                    ),
                    const SizedBox(height: Dimensions.padding),
                    _buildInfoTile(
                      icon: Icons.person,
                      title: AppStrings.firstName,
                      value: user.fullName,
                      context: context,
                    ),
                    const SizedBox(height: Dimensions.padding),
                    _buildInfoTile(
                      icon: Icons.person,
                      title: AppStrings.lastName,
                      value: user.lastName,
                      context: context,
                    ),
                    const SizedBox(height: Dimensions.padding),
                    _buildInfoTile(
                      icon: Icons.email,
                      title: AppStrings.email,
                      value: user.email,
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.padding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(Dimensions.radius),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: context.primaryColor,
            radius: Dimensions.paddingLarge,
            child: Icon(
              icon,
              color: AppColors.surface,
              size: Dimensions.iconSmall,
            ),
          ),
          const SizedBox(width: Dimensions.padding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSmall),
                Text(
                  value,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
