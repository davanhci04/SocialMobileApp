import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/presentation/cubits/auth_cubits.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Home"),
          centerTitle: true,
          actions:  [
            IconButton(onPressed: () {context.read<AuthCubit>().logout();}, icon: Icon(Icons.logout),)
        ],
      ),
    );
  }
}
