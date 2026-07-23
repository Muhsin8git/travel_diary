import 'package:flutter/material.dart';

class RoleBadge extends StatelessWidget {
  final String role;

  const RoleBadge({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (role.toLowerCase()) {
      case 'owner':
        bg = Theme.of(context).colorScheme.secondary.withOpacity(0.15);
        fg = Theme.of(context).colorScheme.secondary;
        break;
      case 'admin':
        bg = Theme.of(context).colorScheme.primary.withOpacity(0.15);
        fg = Theme.of(context).colorScheme.primary;
        break;
      default:
        bg = Colors.grey.withOpacity(0.15);
        fg = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        role,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
