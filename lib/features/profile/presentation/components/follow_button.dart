import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    required this.isFollowing,
    this.onPressed,
    super.key,
  });

  final bool isFollowing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MaterialButton(
          padding: const EdgeInsets.all(25),
          onPressed: onPressed,
          color: isFollowing ? Theme.of(context).colorScheme.primary : Colors.blue,
          child: Text(
            isFollowing ? 'Unfollow' : 'Follow',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
