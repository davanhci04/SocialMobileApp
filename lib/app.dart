import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/data/firebase_auth_repo.dart';
import 'package:untitled/features/auth/presentation/cubits/auth_states.dart';
import 'package:untitled/features/profile/data/firebase_profile_repo.dart';
import 'package:untitled/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:untitled/features/storage/data/firebase_storage_repo.dart';
import 'package:untitled/features/storage/domain/storage_repo.dart';
import 'package:untitled/themes/light_mode.dart';

import 'features/auth/presentation/cubits/auth_cubits.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  final firebaseAuthRepo = FirebaseAuthRepo();
  final firebaseProfileRepo = FirebaseProfileRepo(); // Đảm bảo đúng tên class
  final firebaseStorageRepo = FirebaseStorageRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
            profileRepo: firebaseProfileRepo,
            storageRepo: firebaseStorageRepo,
            ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
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
      ),
    );
  }
}
