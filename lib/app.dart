import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/data/firebase_auth_repo.dart';
import 'package:untitled/features/auth/presentation/cubits/auth_states.dart';
import 'package:untitled/features/post/data/firebase_post_repo.dart';
import 'package:untitled/features/post/presentation/cubits/post_cubit.dart';
import 'package:untitled/features/profile/data/firebase_profile_repo.dart';
import 'package:untitled/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:untitled/features/search/data/firebase_search_repo.dart';
import 'package:untitled/features/search/presentation/cubits/search_cubit.dart';
import 'package:untitled/features/storage/data/firebase_storage_repo.dart';
import 'package:untitled/themes/dark_mode.dart';
import 'package:untitled/themes/light_mode.dart';
import 'package:untitled/themes/theme_cubit.dart';

import 'features/auth/presentation/cubits/auth_cubits.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final profileRepo = FirebaseProfileRepo(); // Đảm bảo đúng tên class
  final postRepo = FirebasePostRepo();
  final storageRepo = FirebaseStorageRepo();
  final searchRepo = FirebaseSearchRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) =>
          AuthCubit(authRepo: authRepo)
            ..checkAuth(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(profileRepo: profileRepo, storageRepo: storageRepo),
        ),
        BlocProvider<PostCubit>(
          create: (context) => PostCubit(postRepo: postRepo, storageRepo: storageRepo),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(searchRepo: searchRepo),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state,
            home: BlocConsumer<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Unauthenticated) {
                  return const AuthPage();
                }
                if (authState is Authenticated) {
                  return const HomePage();
                } else {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
