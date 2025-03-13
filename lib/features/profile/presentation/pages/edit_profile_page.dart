import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/profile/domain/entities/profile_user.dart';
import 'package:untitled/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:untitled/features/profile/presentation/cubits/profile_states.dart';
import '../../../auth/presentation/comoinents/my_text_field.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController bioController = TextEditingController();

  // Cập nhật profile
  void updateProfile() {
    final profileCubit = context.read<ProfileCubit>();

    if (bioController.text.isNotEmpty) {
      profileCubit.updateProfile(
        widget.user.uid,
        bioController.text, null, null
        );
    }
  }

  @override
  void initState() {
    super.initState();
    bioController.text = widget.user.bio;
  }

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Loading......"),
                ],
              ),
            ),
          );
        }
        return buildEditPage(
          context: context,
          bioController: bioController,
          bio: widget.user.bio,
          updateProfile: updateProfile,
        );
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }
}

Widget buildEditPage({
  required BuildContext context,
  required TextEditingController bioController,
  required String bio,
  required VoidCallback updateProfile,
}) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Edit Profile"),
      foregroundColor: Theme.of(context).colorScheme.primary,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: updateProfile,
          icon: const Icon(Icons.upload),
        )
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Bio",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
              controller: bioController,
              hintText: "Enter your bio...",
              obscureText: false,
            ),
          ),
        ],
      ),
    ),
  );
}
