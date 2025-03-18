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
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  late AppUser? currentUser = authCubit.currentUser;

  int postCount = 0;

  @override
  void initState() {
    super.initState();
    profileCubit.fetchUserProfile(widget.uid);
  }

  void followButtonPressed() {
    final profileState = profileCubit.state;
    if (profileState is! ProfileLoaded) return;

    final profileUser = profileState.profileUser;
    final isFollowing = profileUser.followers.contains(currentUser!.uid);

    setState(() {
      isFollowing ? profileUser.followers.remove(currentUser!.uid) : profileUser.followers.add(currentUser!.uid);
    });

    profileCubit.toggleFollow(currentUser!.uid, widget.uid).catchError((e) {
      setState(() {
        isFollowing ? profileUser.followers.add(currentUser!.uid) : profileUser.followers.remove(currentUser!.uid);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isOwnProfile = widget.uid == currentUser!.uid;

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded) {
        final user = state.profileUser;
        return Scaffold(
          appBar: AppBar(
            title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
              if (isOwnProfile)
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage(user: user)),
                  ),
                  icon: const Icon(Icons.settings),
                )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.cyanAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Column(
                    children: [
                      // Avatar với viền sáng
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [Colors.white, Colors.blueAccent]),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 60, color: Colors.blueAccent),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Email
                      Text(user.email, style: const TextStyle(color: Colors.white, fontSize: 16)),
                      const SizedBox(height: 10),

                      // Thống kê profile
                      BlocBuilder<PostCubit, PostState>(
                        builder: (context, state) {
                          if (state is PostsLoaded) {
                            postCount = state.posts.where((p) => p.userId == widget.uid).length;
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
                      const SizedBox(height: 10),

                      // Nút Follow
                      if (!isOwnProfile)
                        FollowButton(
                          onPressed: followButtonPressed,
                          isFollowing: user.followers.contains(currentUser!.uid),
                        ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                // Tiểu sử (Bio)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Bio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 5),
                      BioBox(text: user.bio),
                    ],
                  ),
                ),

                // Bài đăng
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Posts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 5),
                      BlocBuilder<PostCubit, PostState>(
                        builder: (context, state) {
                          if (state is PostsLoaded) {
                            final userPosts = state.posts.where((p) => p.userId == widget.uid).toList();
                            postCount = userPosts.length;

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: postCount,
                              itemBuilder: (context, index) {
                                final post = userPosts[index];
                                return Card(
                                  elevation: 4,
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: PostTile(
                                      post: post,
                                      onDeletePressed: () => context.read<PostCubit>().deletePost(post.id),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          if (state is PostsLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return const Center(child: Text('No posts available.'));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }

      // Loading...
      if (state is ProfileLoading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return const Scaffold(body: Center(child: Text('No profile found')));
    });
  }
}
