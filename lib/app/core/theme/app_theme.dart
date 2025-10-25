import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
    // -------------------------
    // Text Theme
    // -------------------------
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: Dimensions.fontHeader,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: Dimensions.fontTitle,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: Dimensions.fontLarge,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: Dimensions.fontMedium,
        color: AppColors.textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: Dimensions.fontSmall,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    ),

    // -------------------------
    // AppBar Theme
    // -------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.textOnPrimary,
        fontSize: Dimensions.fontLarge,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: AppColors.textOnPrimary),
    ),

    // -------------------------
    // Button Theme
    // -------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        textStyle: TextStyle(
          fontSize: Dimensions.fontMedium,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        textStyle: TextStyle(
          fontSize: Dimensions.fontMedium,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // -------------------------
    // Input Field Theme
    // -------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      hintStyle: TextStyle(
        color: AppColors.textSecondary,
        fontSize: Dimensions.fontMedium,
      ),
    ),

    // -------------------------
    // Card Theme
    // -------------------------
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: Dimensions.elevationLow,
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.padding,
        vertical: Dimensions.paddingSmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
      ),
    ),

    // -------------------------
    // Divider Theme
    // -------------------------
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 0,
    ),

    // -------------------------
    // Progress Indicator
    // -------------------------
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      circularTrackColor: AppColors.surface,
    ),
  );
}

