import 'package:flutter/material.dart';
import '../../models/models.dart';

class MembersTab extends StatelessWidget {
  final Trip trip;

  const MembersTab({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: trip.members.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final member = trip.members[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(member.avatarUrl),
          ),
          title: Text(
            member.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(member.role),
          trailing: member.role == 'Owner'
              ? Icon(Icons.star, color: Theme.of(context).colorScheme.secondary)
              : null,
        );
      },
    );
  }
}
