import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/profile/presentation/components/user_tile.dart';
import 'package:untitled/features/search/presentation/cubits/search_cubit.dart';
import 'package:untitled/features/search/presentation/cubits/search_states.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late final SearchCubit _searchCubit;

  void onSearchChanged() {
    final query = _searchController.text;
    _searchCubit.searchUsers(query);
  }

  @override
  void initState() {
    super.initState();
    _searchCubit = context.read<SearchCubit>();
    _searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return const Center(child: Text("Enter a search query"));
          } else if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
            if (state.users.isEmpty) {
              return const Center(child: Text('No users found'));
            }
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return UserTile(user: user);
              },
            );
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          }
          return const Center(
            child: Text('Start searching for users...'),
          );
        },
      ),
    );
  }
}
