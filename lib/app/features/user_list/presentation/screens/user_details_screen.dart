import 'package:flutter/material.dart';
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
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.primaryColor,
                    context.primaryColor.withValues(alpha: 0.7),
                  ],
                ),
              ),
              child: Center(
                child: Hero(
                  tag: 'user_${user.id}',
                  child: Container(
                    width: Dimensions.avatarHuge,
                    height: Dimensions.avatarHuge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.surface,
                        width: 4,
                      ),
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
              ),
            ),
            const SizedBox(height: Dimensions.paddingLarge),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSmall),
              child: Column(
                children: [
                  _buildInfoCard(
                    icon: Icons.badge,
                    title: AppStrings.userID,
                    value: '#${user.id}',
                    context: context,
                  ),
                  const SizedBox(height: Dimensions.paddingSmall),
                  _buildInfoCard(
                    icon: Icons.person,
                    title: AppStrings.fullName,
                    value: user.fullName,
                    context: context,
                  ),
                  const SizedBox(height: Dimensions.paddingSmall),
                  _buildInfoCard(
                    icon: Icons.email,
                    title: AppStrings.email,
                    value: user.email,
                    context: context,
                  ),
                  const SizedBox(height: Dimensions.paddingSmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required BuildContext context,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.padding),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: context.primaryColor,
              ),
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 4),
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
      ),
    );
  }
}
