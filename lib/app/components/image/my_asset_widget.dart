import 'dart:io';
import 'package:flutter/material.dart';

class MyAssetImageWidget extends StatelessWidget {
  final String assetPath;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit boxFit;
  final bool isFile;
  final Color? color;

  const MyAssetImageWidget({
    super.key,
    required this.assetPath,
    this.height = 80,
    this.width = 100,
    this.radius = 5,
    this.boxFit = BoxFit.fitHeight,
    this.isFile = false, // Set to true if File
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        // color: color?.withValues(alpha:0.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: isFile
            ? _buildFileImage() // Handle File images
            : _buildAssetImage(), // Handle PNG/JPG images
      ),
    );
  }

  Widget _buildFileImage() {
    return Image.file(
      File(assetPath),
      height: height,
      width: width,
      fit: boxFit,
      color: color,
      colorBlendMode: color != null ? BlendMode.srcIn : null,
    );
  }

  Widget _buildAssetImage() {
    return Image.asset(
      assetPath,
      height: height,
      width: width,
      fit: boxFit,
      color: color,
      colorBlendMode: color != null ? BlendMode.srcIn : null,
    );
  }
}
