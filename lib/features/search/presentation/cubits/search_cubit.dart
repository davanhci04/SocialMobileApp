import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_tute/features/search/domain/repos/search_repo.dart';
import 'package:social_app_tute/features/search/presentation/cubits/search_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => SearchCubit(searchRepo: FirebaseSearchRepo()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return Center(child: Text("Enter a search query"));
          } else if (state is SearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(state.users[index].name),
              ),
            );
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cubit = context.read<SearchCubit>();
          cubit.searchUsers("example"); // Thay bằng input từ người dùng
        },
        child: Icon(Icons.search),
      ),
    );
  }
}