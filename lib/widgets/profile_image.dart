import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  final bool isVerified;
  final double size;
  final bool showStatus;

  const ProfileImage({
    super.key,
    required this.imageUrl,
    required this.isVerified,
    this.size = 60,
    this.showStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundImage: imageUrl.isNotEmpty
              ? NetworkImage(imageUrl) as ImageProvider
              : const AssetImage('assets/default_profile.png'),
          backgroundColor: Colors.grey[200],
        ),
        if (showStatus)
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: size / 10,
              backgroundColor: isVerified ? Colors.green : Colors.red,
              child: isVerified
                  ? null
                  : const Icon(Icons.warning, size: 10, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
