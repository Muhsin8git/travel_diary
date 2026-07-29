enum DiscoveryType {
  event,
  destination,
  communityTrip,
  experience,
  festival,
  hiddenGem,
  adventure,
  roadTrip,
  camping,
  hiking,
  recommendation,
  bikerClub,
  offRoading,
  wildlifeSafari,
}

class DiscoveryItem {
  final String id;
  final String title;
  final String subtitle;
  final DiscoveryType type;
  final String location;
  final String cityTag; // 'Kochi', 'Bengaluru', 'Mumbai', 'Dubai', 'Bali', 'Tokyo', 'London'
  final String imageUrl;
  final double rating;
  final String dateStr;
  final String priceOrBudget;
  final int attendeesCount;
  final int? seatsLeft;
  final List<String> tags; // e.g. ['Biker Club', 'Nearby', 'Beach', 'Food']
  final String description;
  final String organizerName;
  final String organizerAvatar;
  final String? difficulty;
  final String? duration;
  final List<String> galleryPhotos;
  final String? recommendationPrompt;
  final String? associatedClubName;
  final bool isClubPrivate;
  final double? fundraiserTarget;
  final double? fundraiserRaised;
  final int friendsJoinedCount;
  final String audienceType; // e.g. '👨‍👩‍👧‍👦 Family Friendly', '🏍️ Bikers Only', '🥾 Hardcore Trekkers', '👥 Open to All'

  DiscoveryItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.location,
    required this.cityTag,
    required this.imageUrl,
    this.rating = 4.8,
    required this.dateStr,
    required this.priceOrBudget,
    this.attendeesCount = 12,
    this.seatsLeft,
    required this.tags,
    required this.description,
    required this.organizerName,
    required this.organizerAvatar,
    this.difficulty,
    this.duration,
    this.galleryPhotos = const [],
    this.recommendationPrompt,
    this.associatedClubName,
    this.isClubPrivate = false,
    this.fundraiserTarget,
    this.fundraiserRaised,
    this.friendsJoinedCount = 3,
    this.audienceType = '👨‍👩‍👧‍👦 Family Friendly',
  });
}
