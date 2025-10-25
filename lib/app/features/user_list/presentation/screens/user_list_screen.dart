import 'package:flutter/material.dart';
import 'package:user_app_assessment/app/core/di/service_locator.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/bloc/user_list_bloc.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/bloc/user_list_event.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/bloc/user_list_state.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/screens/widgets/search_box_widget.dart';
import 'widgets/users_listview_widget.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final UserListBloc _userListBloc;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchBoxController = TextEditingController();

  void scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (_userListBloc.state is UserListLoaded && (_userListBloc.state as UserListLoaded).hasNextPage && _searchBoxController.text.isEmpty) {
        // Only fetch more if not searching
        _userListBloc.add(const FetchUserListEvent());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _userListBloc = serviceLocator<UserListBloc>();

    // Fetch first page
    _userListBloc.add(const FetchUserListEvent());

    // Listen for scroll end to load more
    _scrollController.addListener(scrollListener);

    // Listen to search changes
    _searchBoxController.addListener(() {
      _userListBloc.add(SearchUserListEvent(_searchBoxController.text));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchBoxController.dispose();
    _userListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.appTitle)),
      body: Column(
        children: [
          // Search Bar
          SearchBoxWidget(
            searchBoxController: _searchBoxController,
          ),
          // Expanded list
          Expanded(
            child: UsersListWidget(
              userListBloc: _userListBloc,
              scrollController: _scrollController,
              searchQuery: _searchBoxController.text,
            ),
          ),
        ],
      ),
    );
  }
}
