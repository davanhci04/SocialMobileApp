import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/domain/entities/app_user.dart';
import 'package:untitled/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:untitled/features/home/presentation/components/post_tile.dart';
import 'package:untitled/features/post/presentation/cubits/post_cubit.dart';
import 'package:untitled/features/post/presentation/cubits/post_states.dart';
import 'package:untitled/features/profile/presentation/components/bio_box.dart';
import 'package:untitled/features/profile/presentation/components/follow_button.dart';
import 'package:untitled/features/profile/presentation/components/profile_stats.dart';
import 'package:untitled/features/profile/presentation/cubits/profile_states.dart';

import '../cubits/profile_cubit.dart';
import 'edit_profile_page.dart';
import 'follower_page.dart';

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

  int postCount = 0;

  @override
  void initState() {
    super.initState();
    profileCubit.fetchUserProfile(widget.uid);
  }

  void followButtonPressed() {
    final profileState = profileCubit.state;
    if (profileState is! ProfileLoaded) {
      return;
    }
    final profileUser = profileState.profileUser;
    final isFollowing = profileUser.followers.contains(currentUser!.uid);
    setState(() {
      if (isFollowing) {
        profileUser.followers.remove(currentUser!.uid);
      } else {
        profileUser.followers.add(currentUser!.uid);
      }
    });
    profileCubit.toggleFollow(currentUser!.uid, widget.uid).catchError((e) {
      setState(() {
        if (isFollowing) {
          profileUser.followers.add(currentUser!.uid);
        } else {
          profileUser.followers.remove(currentUser!.uid);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isOwnPost = widget.uid == currentUser!.uid;
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
              if (isOwnPost)
                IconButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditProfilePage(user: user)),
                        ),
                    icon: const Icon(Icons.settings))
            ],
          ),
          // body
          body: ListView(
            children: [
              Center(
                  child: Text(
                user.email,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
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
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 72,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )),
              // bio
              const SizedBox(height: 20),

              BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  if (state is PostsLoaded) {
                    final userPosts = state.posts
                        .where((p) => p.userId == widget.uid)
                        .toList();
                    postCount = userPosts.length;
                  }
                  return ProfileStats(
                    postCount: postCount,
                    followerCount: user.followers.length,
                    followingCount: user.following.length,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FollowerPage(
                          followers: user.followers,
                          following: user.following,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              if (!isOwnPost)
                FollowButton(
                  onPressed: followButtonPressed,
                  isFollowing: user.followers.contains(currentUser!.uid),
                ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Text(
                      "Bio",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              BioBox(text: user.bio),

              // posts
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10),
                child: Row(
                  children: [
                    Text(
                      "Posts",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  if (state is PostsLoaded) {
                    final userPosts = state.posts
                        .where((p) => p.userId == widget.uid)
                        .toList();
                    postCount = userPosts.length;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: postCount,
                      itemBuilder: (context, index) {
                        final post = userPosts[index];
                        return PostTile(
                          post: post,
                          onDeletePressed: () =>
                              context.read<PostCubit>().deletePost(post.id),
                        );
                      },
                    );
                  }

                  if (state is PostsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text('No posts...'));
                  }
                },
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
