import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_app_assessment/app/core/di/service_locator.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/bloc/user_list_bloc.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/bloc/user_list_event.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/bloc/user_list_state.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/screens/widgets/user_list_info_card.dart';
import 'package:user_app_assessment/app/router/route_helper.dart';

import 'widgets/user_list_shimmer.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final UserListBloc _userListBloc;
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';

  void scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (_userListBloc.state is UserListLoaded && (_userListBloc.state as UserListLoaded).hasNextPage && _searchQuery.isEmpty) {
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
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                isDense: true,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _userListBloc.add(SearchUserListEvent(value));
              },
            ),
          ),
          // Expanded list
          Expanded(
            child: BlocConsumer<UserListBloc, UserListState>(
              bloc: _userListBloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is UserListLoading) {
                  return const UserListShimmer(itemCount: 10);
                }

                if (state is UserListError) {
                  return Center(
                    child: Text('❌ ${state.message}', style: const TextStyle(color: Colors.red)),
                  );
                }

                if (state is UserListNoMoreData) {
                  return const Center(child: Text('No users found'));
                }

                if (state is UserListLoaded) {
                  if (state.users.isEmpty) {
                    return const Center(child: Text('No users available'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      _userListBloc.add(const RefreshUserListEvent());
                    },
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: state.users.length + 1,
                      separatorBuilder: (context, index) => SizedBox(height: 0),
                      itemBuilder: (context, index) {
                        if (index == state.users.length) {
                          return state.hasNextPage && _searchQuery.isEmpty
                              ? const UserListShimmer(
                                  scrollPhysics: NeverScrollableScrollPhysics(),
                                  itemCount: 1,
                                )
                              : const SizedBox.shrink();
                        }

                        final user = state.users[index];
                        return UseListInfoCard(
                          user: user,
                          onTap: () {
                            context.pushNamed(RouteHelper.userDetailsScreen, extra: user);
                          },
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
