import 'package:flutter/material.dart';

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
    _searchCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SEARCH"),
      ), // AppBar
    );
  }
}