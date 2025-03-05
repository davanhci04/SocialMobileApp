import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/domain/entities/app_user.dart';
import 'package:untitled/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:untitled/features/profile/presentation/components/bio_box.dart';
import 'package:untitled/features/profile/presentation/cubits/profile_states.dart';

import '../cubits/profile_cubit.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Cubit
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  // Current user
  late AppUser? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      //loaded
      if (state is ProfileLoaded) {
        // get loaded user
        final user = state.profileUser;
        return Scaffold(
          appBar: AppBar(
            title: Text(user.name),
            foregroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            actions: [
              //edit profile button
              IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditProfilePage( user: user)),),
                  icon: const Icon(Icons.settings))
            ],
          ),
          // body
          body: Column(
            children: [
              Center(
                  child: Text(
                user.email,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
              )),
              const SizedBox(height: 20),
              // profile image
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(25),
                child: Center(child: Icon(Icons.person,size: 72,color: Theme.of(context).colorScheme.primary,),)
              ),
              // bio
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Text("Bio", style : TextStyle(color: Theme.of(context).colorScheme.primary),),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              BioBox(text: user.bio),

              // posts
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top : 10),
                child: Row(
                  children: [
                    Text("Posts", style : TextStyle(color: Theme.of(context).colorScheme.primary),),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      //loading...
      else if (state is ProfileLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return const Center(
          child: Text('No profile found'),
        );
      }
    });
  }
}
