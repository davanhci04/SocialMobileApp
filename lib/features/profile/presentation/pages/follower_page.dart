import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/profile/presentation/components/user_tile.dart';
import 'package:untitled/features/profile/presentation/cubits/profile_cubit.dart';

class FollowerPage extends StatelessWidget {
  const FollowerPage({
    required this.following,
    required this.followers,
    super.key,
  });

  final List<String> followers;
  final List<String> following;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            dividerColor: Colors.transparent,
            labelColor: Theme.of(context).colorScheme.inversePrimary,
            unselectedLabelColor: Theme.of(context).colorScheme.primary,
            tabs: [
              Tab(text: 'Followers'),
              Tab(text: 'Following'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUserList(followers, 'No followers', context),
            _buildUserList(following, 'No following', context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(List<String> uids, String emptyMessage, BuildContext context) {
    return uids.isEmpty
        ? Center(child: Text(emptyMessage))
        : ListView.builder(
            itemCount: uids.length,
            itemBuilder: (context, index) {
              final uid = uids[index];
              return FutureBuilder(
                future: context.read<ProfileCubit>().getUserProfile(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return UserTile(user: user);
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(title: Text('Loading...'));
                  } else {
                    return const ListTile(title: Text('User not found.'));
                  }
                },
              );
            },
          );
  }
}
