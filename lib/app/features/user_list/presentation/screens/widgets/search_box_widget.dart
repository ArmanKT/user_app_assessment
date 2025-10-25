import 'package:flutter/material.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    super.key,
    required TextEditingController searchBoxController,
  }) : _searchBoxController = searchBoxController;

  final TextEditingController _searchBoxController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.appBarTheme.backgroundColor,
      padding: const EdgeInsets.all(Dimensions.padding),
      child: TextField(
        controller: _searchBoxController,
        decoration: InputDecoration(
          hintText: AppStrings.searchHint,
          prefixIcon: const Icon(
            Icons.search,
            size: Dimensions.iconMedium,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          isDense: true,
          suffixIcon: IconButton(
              onPressed: () {
                _searchBoxController.clear();
              },
              icon: const Icon(
                Icons.close,
                size: Dimensions.iconMedium,
              )),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
