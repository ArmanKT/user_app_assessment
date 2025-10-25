import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_app_assessment/app/components/nodate/no_data_widget.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/bloc/user_list_event.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/screens/widgets/user_list_info_card.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/screens/widgets/user_list_shimmer.dart';

import '../../../../../router/route_helper.dart';
import '../../bloc/user_list_bloc.dart';
import '../../bloc/user_list_state.dart';

class UsersListWidget extends StatelessWidget {
  const UsersListWidget({
    super.key,
    required UserListBloc userListBloc,
    required ScrollController scrollController,
    required String searchQuery,
  })  : _userListBloc = userListBloc,
        _scrollController = scrollController,
        _searchQuery = searchQuery;

  final UserListBloc _userListBloc;
  final ScrollController _scrollController;
  final String _searchQuery;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListBloc, UserListState>(
      bloc: _userListBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserListLoading) {
          return const UserListShimmer(itemCount: 10);
        }

        // No internet or list error with retry system
        if (state is UserListError) {
          return NoDataWidget(
            imagePath: AppImages.noDataImage,
            title: state.message,
            buttonText: AppStrings.retry,
            onRetry: () {
              _userListBloc.add(const RefreshUserListEvent());
            },
          );
        }
        // No data found 
        if (state is UserListNoMoreData) {
          return NoDataWidget(
            imagePath: AppImages.noDataImage,
            title: AppStrings.noUsersFound,
          );
        }

        if (state is UserListLoaded) {
          if (state.users.isEmpty) {
            // No data found
            return NoDataWidget(
              imagePath: AppImages.noDataImage,
              title: AppStrings.noUsersFound,
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _userListBloc.add(const RefreshUserListEvent());
            },
            child: ListView.separated(
              controller: _scrollController,
              itemCount: state.users.length + 1,
              physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              padding: EdgeInsets.symmetric(vertical: Dimensions.padding),
              separatorBuilder: (context, index) => SizedBox(height: 0),
              itemBuilder: (context, index) {
                if (index == state.users.length) {
                  return state.hasNextPage && _searchQuery.isEmpty
                      ? const UserListShimmer(
                          scrollPhysics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          padding: EdgeInsets.zero,
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
    );
  }
}
