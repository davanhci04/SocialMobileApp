import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
    this.onTap,
    super.key,
  });

  final int postCount;
  final int followerCount;
  final int followingCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var textStyleForCount = TextStyle(
      fontSize: 20,
      color: Theme.of(context).colorScheme.inversePrimary,
    );
    var textStyleForText = TextStyle(
      fontSize: 20,
      color: Theme.of(context).colorScheme.primary,
    );

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  postCount.toString(),
                  style: textStyleForCount,
                ),
                Text(
                  'Posts',
                  style: textStyleForText,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  followerCount.toString(),
                  style: textStyleForCount,
                ),
                Text(
                  'Followers',
                  style: textStyleForText,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  followingCount.toString(),
                  style: textStyleForCount,
                ),
                Text(
                  'Following',
                  style: textStyleForText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
