import 'package:flutter/material.dart';
import '../models/models.dart';

class MemberAvatar extends StatelessWidget {
  final Member member;
  final double radius;

  const MemberAvatar({
    super.key,
    required this.member,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(member.avatarUrl),
        ),
        const SizedBox(height: 8),
        Text(
          member.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          member.role,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
