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
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.inversePrimary,
    );
    var textStyleForText = TextStyle(
      fontSize: 16, // Giảm size để tránh tràn dòng
      color: Theme.of(context).colorScheme.primary,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(postCount, "Posts", textStyleForCount, textStyleForText),
        _buildStatItem(followerCount, "Followers", textStyleForCount, textStyleForText, onTap),
        _buildStatItem(followingCount, "Following", textStyleForCount, textStyleForText, onTap),
      ],
    );
  }

  Widget _buildStatItem(int count, String label, TextStyle countStyle, TextStyle textStyle, [VoidCallback? onTap]) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count.toString(), style: countStyle),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(label, style: textStyle),
            ),
          ],
        ),
      ),
    );
  }
}
