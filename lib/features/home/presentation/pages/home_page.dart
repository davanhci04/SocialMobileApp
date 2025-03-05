import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/presentation/cubits/auth_cubits.dart';

import '../components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //build ui
  @override
  Widget build(BuildContext context) {
    // Scaffold
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      // drawer

      drawer: MyDrawer(),
    );
  }
}
