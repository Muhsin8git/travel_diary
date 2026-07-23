import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../widgets/role_badge.dart';

class MembersTab extends StatefulWidget {
  final Trip trip;

  const MembersTab({super.key, required this.trip});

  @override
  State<MembersTab> createState() => _MembersTabState();
}

class _MembersTabState extends State<MembersTab> {
  late List<Member> _members;
  // Dummy current user role for testing context menu options (assumed Owner for demo)
  final String _currentUserRole = 'Owner';

  @override
  void initState() {
    super.initState();
    _members = List.from(widget.trip.members);
  }

  void _showInviteModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 12),
                  child: Text(
                    'Invite Members',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(Icons.share, color: Theme.of(context).colorScheme.primary),
                  ),
                  title: const Text('Share Link'),
                  subtitle: const Text('Send a direct link to join this trip'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Trip link copied to clipboard!')),
                    );
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    child: Icon(Icons.qr_code, color: Theme.of(context).colorScheme.secondary),
                  ),
                  title: const Text('QR Code'),
                  subtitle: const Text('Scan QR code to join instantly'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showQRCodeDialog();
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple.withOpacity(0.15),
                    child: const Icon(Icons.alternate_email, color: Colors.purple),
                  ),
                  title: const Text('Username'),
                  subtitle: const Text('Search by Travel Tribe handle'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showUsernameInviteDialog();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showQRCodeDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Trip QR Code', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.qr_code_2,
                  size: 160,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Scan to join ${widget.trip.destination}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showUsernameInviteDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Invite by Handle'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '@username',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Invitation sent to ${controller.text}')),
                );
              },
              child: const Text('Invite'),
            ),
          ],
        );
      },
    );
  }

  void _showMemberOptionsMenu(Member member, int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(member.avatarUrl)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          RoleBadge(role: member.role),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // Actions based on Current User Role
                if (_currentUserRole == 'Owner' && member.role != 'Owner')
                  ListTile(
                    leading: const Icon(Icons.admin_panel_settings_outlined),
                    title: Text(member.role == 'Admin' ? 'Demote to Member' : 'Make Admin'),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      setState(() {
                        final newRole = member.role == 'Admin' ? 'Member' : 'Admin';
                        _members[index] = Member(
                          id: member.id,
                          name: member.name,
                          role: newRole,
                          avatarUrl: member.avatarUrl,
                        );
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${member.name} role updated.')),
                      );
                    },
                  ),
                if ((_currentUserRole == 'Owner' || _currentUserRole == 'Admin') && member.role != 'Owner')
                  ListTile(
                    leading: const Icon(Icons.person_remove_outlined, color: Colors.red),
                    title: const Text('Remove Member', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      setState(() {
                        _members.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${member.name} removed from trip.')),
                      );
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.account_circle_outlined),
                  title: const Text('View Profile'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Viewing ${member.name}\'s profile.')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_members.length} Participants',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ElevatedButton.icon(
                onPressed: _showInviteModal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                icon: const Icon(Icons.person_add, size: 16),
                label: const Text('Invite', style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            itemCount: _members.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final member = _members[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(member.avatarUrl),
                ),
                title: Text(
                  member.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Tap & hold for options', style: TextStyle(fontSize: 11, color: Colors.grey)),
                trailing: RoleBadge(role: member.role),
                onLongPress: () => _showMemberOptionsMenu(member, index),
              );
            },
          ),
        ),
      ],
    );
  }
}
