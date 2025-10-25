import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app_assessment/app/core/di/service_locator.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/app/features/home/presentation/bloc/user_list_bloc.dart';
import 'package:user_app_assessment/app/features/home/presentation/bloc/user_list_event.dart';
import 'package:user_app_assessment/app/features/home/presentation/bloc/user_list_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserListBloc userListBloc;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  final int limit = 10;
  @override
  void initState() {
    super.initState();
    userListBloc = serviceLocator<UserListBloc>();
    userListBloc.add(FetchUserListEvent(page: currentPage, limit: limit));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        userListBloc.add(FetchUserListEvent(page: ++currentPage, limit: limit));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appTitle),
      ),
      body: BlocConsumer<UserListBloc, UserListState>(
        bloc: userListBloc,
        listener: (context, state) {},
        // builder: (context, state) {
        //   return const Column(
        //     children: [
        //       //User list view
        //     ],
        //   );
        // },
        builder: (context, state) {
          if (state is UserListLoading && currentPage == 1) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserListLoaded) {
            if (state.users.isEmpty) {
              return const Center(child: Text('No users available'));
            }
            return ListView.separated(
              controller: _scrollController,
              itemCount: state.users.length + 1,
              separatorBuilder: (_, __) => const Divider(height: 20),
              itemBuilder: (context, index) {
                if (state.users.length == index) {
                  return state.hasNextPage
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }
                final user = state.users[index];
                return ListTile(
                  leading: user.avatar != ""
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar),
                        )
                      : const CircleAvatar(child: Icon(Icons.person)),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email ?? ''),
                );
              },
            );
          } else if (state is UserListError) {
            return Center(child: Text('❌ ${state.message}'));
          } else if (state is UserListNoMoreData) {
            return const Center(child: Text('No more users'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
