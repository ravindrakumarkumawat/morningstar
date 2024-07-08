import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    super.key,
    required this.avatar,
  });

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Image.network(
        avatar,
        width: 40.0,
        height: 40.0,
        fit: BoxFit.cover,
      ),
    );
  }
}