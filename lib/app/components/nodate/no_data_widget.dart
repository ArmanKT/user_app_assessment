import 'package:flutter/material.dart';
import 'package:user_app_assessment/app/components/image/my_asset_widget.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';

class NoDataWidget extends StatelessWidget {
  final String? imagePath;
  final IconData? icon;
  final String title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onRetry;

  const NoDataWidget({
    super.key,
    this.imagePath,
    this.icon,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onRetry,
  }) : assert(
          imagePath != null || icon != null,
          'Either imagePath or icon must be provided',
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image or Icon
            if (imagePath != null)
              MyAssetImageWidget(
                assetPath: imagePath!,
                width: Dimensions.avatarHuge,
                height: Dimensions.avatarHuge,
                color: context.primaryColor,
                boxFit: BoxFit.contain,
              )
            else if (icon != null)
              Container(
                padding: const EdgeInsets.all(Dimensions.paddingLarge),
                decoration: BoxDecoration(
                  color: context.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: Dimensions.iconLarge,
                  color: context.primaryColor,
                ),
              ),
            const SizedBox(height: Dimensions.paddingLarge),
            // Title
            Text(
              title,
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            // Subtitle
            if (subtitle != null) ...[
              const SizedBox(height: Dimensions.paddingSmall),
              Text(
                subtitle!,
                style: context.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            // Button
            if (buttonText != null && onRetry != null) ...[
              const SizedBox(height: Dimensions.paddingLarge),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  foregroundColor: AppColors.surface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingLarge,
                    vertical: Dimensions.padding,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                  ),
                ),
                child: Text(
                  buttonText!,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.surface,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
