import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';
import '../screens/discovery_detail_screen.dart';
import '../screens/club_details_screen.dart';

class DiscoveryCard extends StatelessWidget {
  final DiscoveryItem item;
  final VoidCallback? onSave;

  const DiscoveryCard({
    super.key,
    required this.item,
    this.onSave,
  });

  void _openClubDetails(BuildContext context) {
    final matchedClub = dummyClubs.firstWhere(
      (c) => c.name.toLowerCase() == (item.associatedClubName ?? '').toLowerCase(),
      orElse: () => dummyClubs[0],
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClubDetailsScreen(club: matchedClub)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (item.type == DiscoveryType.recommendation) {
      return _buildRecommendationCard(context);
    }

    final double fundraiserProgress = (item.fundraiserTarget != null && item.fundraiserTarget! > 0)
        ? ((item.fundraiserRaised ?? 0) / item.fundraiserTarget!).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiscoveryDetailScreen(item: item),
            ),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Image.network(
                    item.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.black.withOpacity(0.65),
                      ],
                    ),
                  ),
                ),
                // Type & Permanent Club Badge
                Positioned(
                  top: 14,
                  left: 14,
                  child: Wrap(
                    spacing: 6,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getBadgeColor(context, item.type),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getTypeLabel(item.type),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (item.associatedClubName != null)
                        GestureDetector(
                          onTap: () => _openClubDetails(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item.isClubPrivate ? Icons.lock : Icons.verified,
                                  color: Colors.amber,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 140),
                                  child: Text(
                                    item.associatedClubName!,
                                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Rating & Friends Badge
                Positioned(
                  top: 14,
                  right: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              item.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '👥 ${item.friendsJoinedCount} Friends',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                // Location / Subtitle Bottom Overlay
                Positioned(
                  bottom: 12,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.white70, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            item.location,
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      if (item.dateStr.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            item.dateStr,
                            style: const TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            // Body Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Text(
                      item.audienceType,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (item.fundraiserTarget != null) ...[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fund Pool: ₹${item.fundraiserRaised!.toInt()} / ₹${item.fundraiserTarget!.toInt()}',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                        ),
                        Text('${(fundraiserProgress * 100).toInt()}% Goal', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: fundraiserProgress,
                        minHeight: 6,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(item.organizerAvatar),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item.organizerName,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiscoveryDetailScreen(item: item),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _getButtonLabel(item.type),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildRecommendationCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
            Theme.of(context).colorScheme.secondary.withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      item.recommendationPrompt ?? 'Smart Recommendation',
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.subtitle,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiscoveryDetailScreen(item: item),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 0,
              ),
              icon: const Icon(Icons.explore, size: 16),
              label: const Text('Explore Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor(BuildContext context, DiscoveryType type) {
    switch (type) {
      case DiscoveryType.bikerClub:
        return Colors.deepOrange;
      case DiscoveryType.offRoading:
        return Colors.brown;
      case DiscoveryType.event:
        return Colors.orange;
      case DiscoveryType.communityTrip:
        return Theme.of(context).colorScheme.primary;
      case DiscoveryType.adventure:
        return Colors.redAccent;
      case DiscoveryType.camping:
        return Colors.amber[800]!;
      case DiscoveryType.hiddenGem:
        return Colors.purple;
      default:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  String _getTypeLabel(DiscoveryType type) {
    switch (type) {
      case DiscoveryType.bikerClub:
        return 'BIKER CLUB 🏍️';
      case DiscoveryType.offRoading:
        return '4x4 OFF-ROAD 🚜';
      case DiscoveryType.event:
        return 'EVENT 🎉';
      case DiscoveryType.communityTrip:
        return 'COMMUNITY TRIP 🎒';
      case DiscoveryType.adventure:
        return 'ADVENTURE 🪂';
      case DiscoveryType.camping:
        return 'CAMPING 🏕️';
      case DiscoveryType.hiddenGem:
        return 'HIDDEN GEM 🌿';
      case DiscoveryType.hiking:
        return 'TREK 🥾';
      case DiscoveryType.roadTrip:
        return 'ROAD TRIP 🚗';
      case DiscoveryType.destination:
        return 'DESTINATION 🏝️';
      default:
        return 'EXPERIENCE ✨';
    }
  }

  String _getButtonLabel(DiscoveryType type) {
    switch (type) {
      case DiscoveryType.bikerClub:
        return 'Join Caravan';
      case DiscoveryType.offRoading:
        return 'Join Convoy';
      case DiscoveryType.event:
      case DiscoveryType.camping:
        return 'Join Event';
      case DiscoveryType.communityTrip:
        return 'Join Trip';
      case DiscoveryType.destination:
      case DiscoveryType.hiking:
      case DiscoveryType.roadTrip:
        return 'Plan Trip';
      default:
        return 'Book Spot';
    }
  }
}
