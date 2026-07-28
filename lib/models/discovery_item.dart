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
  final List<String> tags; // e.g. ['Events', 'Nearby', 'Beach', 'Food']
  final String description;
  final String organizerName;
  final String organizerAvatar;
  final String? difficulty;
  final String? duration;
  final List<String> galleryPhotos;
  final String? recommendationPrompt;

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
  });
}
