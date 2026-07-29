import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';
import '../widgets/fundraiser_widget.dart';

class ClubDetailsScreen extends StatefulWidget {
  final TravelClub club;

  const ClubDetailsScreen({
    super.key,
    required this.club,
  });

  @override
  State<ClubDetailsScreen> createState() => _ClubDetailsScreenState();
}

class _ClubDetailsScreenState extends State<ClubDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isJoined = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _toggleJoinClub() {
    setState(() {
      _isJoined = !_isJoined;
    });

    final msg = _isJoined
        ? 'Welcome to ${widget.club.name}! 🎉'
        : 'Left ${widget.club.name}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final club = widget.club;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 240,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  club.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      club.coverUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                            Colors.black.withOpacity(0.85),
                          ],
                        ),
                      ),
                    ),
                    // Badges Overlay
                    Positioned(
                      bottom: 50,
                      left: 16,
                      right: 16,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: club.isPrivate ? Colors.redAccent : Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              club.isPrivate ? '🔒 Private Tribe' : '🌐 Public Club',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '👥 ${club.friendsCount} Friends Joined',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Theme.of(context).cardColor,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  tabs: const [
                    Tab(text: 'Overview'),
                    Tab(text: 'Gallery'),
                    Tab(text: 'Fund Pool'),
                    Tab(text: 'Members'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // 1. Overview & Expeditions
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            club.genre,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '📍 ${club.location} • ${club.memberCount} Members',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: _toggleJoinClub,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isJoined ? Colors.grey[300] : Theme.of(context).colorScheme.primary,
                          foregroundColor: _isJoined ? Colors.black87 : Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        icon: Icon(_isJoined ? Icons.check : Icons.group_add, size: 16),
                        label: Text(_isJoined ? 'Member 🎉' : 'Join Club'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('About This Club', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text(club.description, style: TextStyle(color: Colors.grey[700], fontSize: 14, height: 1.4)),
                  const SizedBox(height: 20),
                  const Text('Club Rules & Guidelines', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  ...club.clubRules.map((rule) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.shield_outlined, size: 16, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Expanded(child: Text(rule, style: const TextStyle(fontSize: 13))),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            // 2. Shared Photo Gallery
            GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: club.sharedGallery.length,
              itemBuilder: (context, index) {
                final photo = club.sharedGallery[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(photo.url, fit: BoxFit.cover),
                );
              },
            ),
            // 3. Trip Fund Pool
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: club.activeFundraiser != null
                  ? FundraiserWidget(fundraiser: club.activeFundraiser!)
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'No active fundraiser pool for this club right now.',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
            ),
            // 4. Members Roster
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: dummyMembers.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final member = dummyMembers[index];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(member.avatarUrl)),
                  title: Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(member.role, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  trailing: const Icon(Icons.chat_bubble_outline, size: 18),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
