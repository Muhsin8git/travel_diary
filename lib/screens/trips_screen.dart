import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';
import '../widgets/role_badge.dart';
import 'trip_details_screen.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  String _selectedFilter = 'All My Trips';
  late List<Trip> _myTrips;

  final List<String> _filterChips = [
    'All My Trips',
    'Created by Me (Admin)',
    'Joined Trips',
    'Looking for Members',
    'Active / Scheduled',
  ];

  @override
  void initState() {
    super.initState();
    _myTrips = List.from(dummyTrips);
  }

  List<Trip> _getFilteredTrips() {
    switch (_selectedFilter) {
      case 'Created by Me (Admin)':
        return _myTrips.where((t) => t.isOwner).toList();
      case 'Joined Trips':
        return _myTrips.where((t) => !t.isOwner).toList();
      case 'Looking for Members':
        return _myTrips.where((t) => t.isOpenForMembers).toList();
      case 'Active / Scheduled':
        return _myTrips.where((t) => t.status == 'Active Now' || t.status == 'Upcoming' || t.status == 'Scheduled').toList();
      default:
        return _myTrips;
    }
  }

  void _showBroadcastDialog(Trip trip) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.campaign, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              const Text('Broadcast Alert'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send a priority push announcement to all ${trip.members.length} members in ${trip.destination}:',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'e.g. Don\'t forget your swimwear for Potato Head Beach Club tomorrow at 10 AM!',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  filled: true,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('📢 Announcement broadcasted to ${trip.members.length} members!'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.send, size: 16),
              label: const Text('Broadcast'),
            ),
          ],
        );
      },
    );
  }

  void _showManageMembersSheet(Trip trip, int tripIndex) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Manage Members (${trip.members.length})',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(sheetContext),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Trip Admins can kick or adjust member roles below.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: trip.members.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final member = trip.members[index];
                          final isOwner = member.role == 'Owner';
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(member.avatarUrl),
                            ),
                            title: Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: RoleBadge(role: member.role),
                            trailing: !isOwner && trip.isOwner
                                ? IconButton(
                                    icon: const Icon(Icons.person_remove, color: Colors.red, size: 20),
                                    onPressed: () {
                                      setSheetState(() {
                                        trip.members.removeAt(index);
                                      });
                                      setState(() {});
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('${member.name} removed from trip.')),
                                      );
                                    },
                                  )
                                : null,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _toggleTripPrivacy(Trip trip) {
    setState(() {
      final updatedTrip = Trip(
        id: trip.id,
        destination: trip.destination,
        coverUrl: trip.coverUrl,
        startDate: trip.startDate,
        endDate: trip.endDate,
        budget: trip.budget,
        status: trip.status,
        isPublic: !trip.isPublic,
        isOwner: trip.isOwner,
        routeEndpoint: trip.routeEndpoint,
        isOpenForMembers: trip.isOpenForMembers,
        activeDay: trip.activeDay,
        members: trip.members,
        chatMessages: trip.chatMessages,
        activities: trip.activities,
        gallery: trip.gallery,
      );
      final idx = _myTrips.indexWhere((t) => t.id == trip.id);
      if (idx != -1) {
        _myTrips[idx] = updatedTrip;
      }
    });

    final newPrivacy = !trip.isPublic ? 'Public 🌐' : 'Private 🔒';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Trip privacy set to $newPrivacy'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTrips = _getFilteredTrips();
    final adminCount = _myTrips.where((t) => t.isOwner).length;
    final activeCount = _myTrips.where((t) => t.status == 'Active Now').length;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Hub Header & Quick Stats Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Trips Hub',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Full control center for trips you manage or joined.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    // Quick Stats Bar
                    Row(
                      children: [
                        _buildStatPill(
                          context,
                          icon: Icons.shield,
                          label: '$adminCount Admin Trips',
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 8),
                        _buildStatPill(
                          context,
                          icon: Icons.directions_run,
                          label: '$activeCount Active Now',
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        _buildStatPill(
                          context,
                          icon: Icons.group,
                          label: '${_myTrips.length} Total',
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Segmented Filter Chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filterChips.length,
                  itemBuilder: (context, index) {
                    final chip = _filterChips[index];
                    final isSelected = _selectedFilter == chip;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(chip),
                        selected: isSelected,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide.none,
                        onSelected: (val) {
                          if (val) {
                            setState(() {
                              _selectedFilter = chip;
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // Managed Trip Cards List
            if (filteredTrips.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final trip = filteredTrips[index];
                      return _buildManagedTripCard(context, trip, index);
                    },
                    childCount: filteredTrips.length,
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Icon(Icons.workspaces_outline, size: 54, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      Text(
                        'No trips match "$_selectedFilter"',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildManagedTripCard(BuildContext context, Trip trip, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Cover Stack with Hero & Badges
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TripDetailsScreen(trip: trip)),
              );
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Hero(
                    tag: 'trip_cover_${trip.id}',
                    child: Image.network(
                      trip.coverUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                // Top Badges Row
                Positioned(
                  top: 14,
                  left: 14,
                  right: 14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoleBadge(role: trip.isOwner ? 'Owner (Admin)' : 'Member'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: trip.status == 'Active Now'
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          trip.status,
                          style: TextStyle(
                            color: trip.status == 'Active Now' ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Destination & Route Chip Overlay
                Positioned(
                  bottom: 14,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.destination,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.alt_route, color: Colors.white70, size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              trip.routeEndpoint,
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (trip.isOpenForMembers)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Open for Members 🎒',
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Direct Action Control Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 4,
              children: [
                if (trip.isOwner)
                  TextButton.icon(
                    onPressed: () => _showBroadcastDialog(trip),
                    icon: const Icon(Icons.campaign, size: 16),
                    label: const Text('Broadcast', style: TextStyle(fontSize: 11)),
                  ),
                TextButton.icon(
                  onPressed: () => _showManageMembersSheet(trip, index),
                  icon: const Icon(Icons.people_alt_outlined, size: 16),
                  label: Text('${trip.members.length} Members', style: const TextStyle(fontSize: 11)),
                ),
                TextButton.icon(
                  onPressed: () => _toggleTripPrivacy(trip),
                  icon: Icon(trip.isPublic ? Icons.public : Icons.lock_outline, size: 16),
                  label: Text(trip.isPublic ? 'Public' : 'Private', style: const TextStyle(fontSize: 11)),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TripDetailsScreen(trip: trip)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.map, size: 14),
                  label: const Text('Control Hub', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(BuildContext context, {required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
