import 'package:flutter/material.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.appTitle),
        ),
        body: const Column(
          children: [
            //User list view
          ],
        ));
  }
}
