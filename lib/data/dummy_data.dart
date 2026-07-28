import '../models/models.dart';

final List<Member> dummyMembers = List.generate(25, (index) {
  final names = [
    'Ahmed', 'Fatima', 'Ali', 'Sarah', 'Omar',
    'Maya', 'Lucas', 'Sophia', 'Noah', 'Emma',
    'Liam', 'Olivia', 'Ethan', 'Ava', 'Jackson',
    'Isabella', 'Aiden', 'Mia', 'Benjamin', 'Charlotte',
    'Elijah', 'Amelia', 'Mason', 'Harper', 'Logan'
  ];
  final roles = index == 0 ? 'Owner' : (index < 4 ? 'Admin' : 'Member');
  final avatarIds = [
    '1599566150163-29194dcaad36', '1494790108377-be9c29b29330', '1507003211169-0a1dd7228f2d',
    '1438761681033-6461ffad8d80', '1500648767791-00dcc994a43e', '1534528741775-53994a69daeb',
    '1522075469751-3a6694fb2f61', '1517841905240-472988babdf9', '1539571696357-5a69c17a67c6',
    '1544005313-94ddf0286df2', '1506794778202-cad84cf45f1d', '1524504388940-b1c1722653e1'
  ];
  return Member(
    id: 'm${index + 1}',
    name: names[index % names.length],
    role: roles,
    avatarUrl: 'https://images.unsplash.com/photo-${avatarIds[index % avatarIds.length]}?auto=format&fit=crop&q=80&w=100',
  );
});

final List<Achievement> dummyAchievements = [
  Achievement(id: 'a1', title: 'Globetrotter', iconName: 'globe'),
  Achievement(id: 'a2', title: 'Mountain Goat', iconName: 'mountain'),
  Achievement(id: 'a3', title: 'Beach Bum', iconName: 'umbrella'),
  Achievement(id: 'a4', title: 'Foodie', iconName: 'utensils'),
];

final List<BadgeItem> dummyBadges = [
  BadgeItem(
    id: 'b1',
    title: 'Globetrotter',
    description: 'Traveled over 10,000 km across multiple regions.',
    iconName: 'globe',
    isEarned: true,
  ),
  BadgeItem(
    id: 'b2',
    title: 'Mountain Goat',
    description: 'Completed 5 hill station and high-altitude treks.',
    iconName: 'mountain',
    isEarned: true,
  ),
  BadgeItem(
    id: 'b3',
    title: 'Beach Bum',
    description: 'Visited 10 coastal beaches around the world.',
    iconName: 'umbrella',
    isEarned: true,
  ),
  BadgeItem(
    id: 'b4',
    title: 'Foodie',
    description: 'Joined 8 local food crawls and night markets.',
    iconName: 'utensils',
    isEarned: true,
  ),
  BadgeItem(
    id: 'b5',
    title: 'Midnight Rider',
    description: 'Completed a 100km overnight road trip.',
    iconName: 'car',
    isEarned: true,
  ),
  BadgeItem(
    id: 'b6',
    title: 'Solo Explorer',
    description: 'Organized your first public community trip.',
    iconName: 'compass',
    isEarned: true,
  ),
  BadgeItem(
    id: 'b7',
    title: 'Desert Nomad',
    description: 'Camping overnight in a sand desert.',
    iconName: 'sun',
    isEarned: false,
  ),
  BadgeItem(
    id: 'b8',
    title: 'Polar Circle',
    description: 'Visiting an Arctic or Northern Lights zone.',
    iconName: 'snowflake',
    isEarned: false,
  ),
  BadgeItem(
    id: 'b9',
    title: '20k Voyager',
    description: 'Reaching 20,000 total travel kilometers.',
    iconName: 'plane',
    isEarned: false,
  ),
  BadgeItem(
    id: 'b10',
    title: 'Island Legend',
    description: 'Exploring 5 island archipelagos.',
    iconName: 'palm_tree',
    isEarned: false,
  ),
];

final List<Photo> dummyPhotos = List.generate(30, (index) {
  final photoUrls = [
    'https://images.unsplash.com/photo-1512100356356-de1b84283e18',
    'https://images.unsplash.com/photo-1542332213-9b5a5a3fad35',
    'https://images.unsplash.com/photo-1499856871958-5b9627545d1a',
    'https://images.unsplash.com/photo-1506929562872-bb421503ef21',
    'https://images.unsplash.com/photo-1534445867742-43195f401b6c',
    'https://images.unsplash.com/photo-1528605248644-14dd04022da1',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
    'https://images.unsplash.com/photo-1502685104226-ee32379fefbe',
    'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2',
    'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1'
  ];
  return Photo(
    id: 'p${index + 1}',
    url: '${photoUrls[index % photoUrls.length]}?auto=format&fit=crop&q=80&w=400',
  );
});

final List<Destination> dummyDestinations = [
  Destination(
    id: 'd1',
    name: 'Bali',
    country: 'Indonesia',
    imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&q=80&w=600',
    rating: 4.9,
    startingBudget: 800.0,
    description: 'Tropical paradise with serene beaches, lush terraces, and rich culture.',
  ),
  Destination(
    id: 'd2',
    name: 'Tokyo',
    country: 'Japan',
    imageUrl: 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&q=80&w=600',
    rating: 4.8,
    startingBudget: 1500.0,
    description: 'Ultra-modern city blending neon skyscrapers with historic temples.',
  ),
];

final List<Trip> dummyTrips = [
  Trip(
    id: 't1',
    destination: 'Bali Adventure',
    coverUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&q=80&w=800',
    startDate: DateTime.now().subtract(const Duration(days: 2)),
    endDate: DateTime.now().add(const Duration(days: 5)),
    budget: 1200.0,
    status: 'Active Now',
    isPublic: true,
    isOwner: true,
    routeEndpoint: 'Kochi ➔ Denpasar, Bali',
    isOpenForMembers: true,
    activeDay: 'Day 3 of 7',
    members: dummyMembers.sublist(0, 4),
    chatMessages: [
      ChatMessage(id: 'c1', sender: dummyMembers[0], message: "Let's leave at 8 AM.", timestamp: DateTime.now().subtract(const Duration(minutes: 60))),
      ChatMessage(id: 'c2', sender: dummyMembers[1], message: "I'll book the hotel.", timestamp: DateTime.now().subtract(const Duration(minutes: 55))),
    ],
    activities: [
      Activity(id: 'a1', title: 'Airport', location: 'Terminal 1', time: DateTime.now().copyWith(hour: 8, minute: 0), iconName: 'plane'),
      Activity(id: 'a2', title: 'Hotel Check-in', location: 'Resort', time: DateTime.now().copyWith(hour: 10, minute: 30), iconName: 'hotel'),
    ],
    gallery: dummyPhotos.sublist(0, 6),
  ),
  Trip(
    id: 't2',
    destination: 'Manali Road Trip',
    coverUrl: 'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?auto=format&fit=crop&q=80&w=800',
    startDate: DateTime.now().add(const Duration(days: 15)),
    endDate: DateTime.now().add(const Duration(days: 20)),
    budget: 500.0,
    status: 'Upcoming',
    isPublic: false,
    isOwner: true,
    routeEndpoint: 'Delhi ➔ Manali, HP',
    isOpenForMembers: true,
    members: dummyMembers.sublist(0, 3),
    chatMessages: [],
    activities: [],
    gallery: dummyPhotos.sublist(6, 12),
  ),
  Trip(
    id: 't3',
    destination: 'Dubai Vacation',
    coverUrl: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&q=80&w=800',
    startDate: DateTime.now().add(const Duration(days: 40)),
    endDate: DateTime.now().add(const Duration(days: 47)),
    budget: 2500.0,
    status: 'Scheduled',
    isPublic: true,
    isOwner: true,
    routeEndpoint: 'Mumbai ➔ Dubai International',
    isOpenForMembers: false,
    members: dummyMembers.sublist(0, 5),
    chatMessages: [],
    activities: [],
    gallery: dummyPhotos.sublist(12, 18),
  ),
  Trip(
    id: 't4',
    destination: 'Swiss Alps Expedition',
    coverUrl: 'https://images.unsplash.com/photo-1530122037265-a5f1f91d3b99?auto=format&fit=crop&q=80&w=800',
    startDate: DateTime.now().add(const Duration(days: 60)),
    endDate: DateTime.now().add(const Duration(days: 68)),
    budget: 3100.0,
    status: 'Scheduled',
    isPublic: true,
    isOwner: false, // Joined trip
    routeEndpoint: 'Zurich ➔ Zermatt, Switzerland',
    isOpenForMembers: true,
    members: dummyMembers.sublist(4, 10),
    chatMessages: [],
    activities: [],
    gallery: dummyPhotos.sublist(18, 22),
  ),
];

final List<DiscoveryItem> dummyDiscoveryItems = [
  // --- KOCHI DISCOVERY ITEMS ---
  DiscoveryItem(
    id: 'disc_k1',
    title: 'Fort Kochi Heritage Night Walk',
    subtitle: 'Colonial streets, Chinese nets & local snacks',
    type: DiscoveryType.experience,
    location: 'Fort Kochi, India',
    cityTag: 'Kochi',
    imageUrl: 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?auto=format&fit=crop&q=80&w=800',
    rating: 4.9,
    dateStr: 'Tonight, 7:00 PM',
    priceOrBudget: '₹499',
    attendeesCount: 24,
    tags: ['Nearby', 'Food', 'Culture', 'Experience'],
    description: 'Explore the historic alleys of Fort Kochi with a local storyteller. Visit ancient spice markets and taste fresh street food under twilight.',
    organizerName: 'Kochi Heritage Club',
    organizerAvatar: dummyMembers[0].avatarUrl,
    duration: '2.5 Hours',
  ),
  DiscoveryItem(
    id: 'disc_k2',
    title: 'Rainy Weekend in Munnar?',
    subtitle: 'Misty tea hills & lush waterfall trails just 3 hrs away',
    type: DiscoveryType.recommendation,
    location: 'Munnar, Kerala',
    cityTag: 'Kochi',
    imageUrl: 'https://images.unsplash.com/photo-1593693397690-362cb9666fc2?auto=format&fit=crop&q=80&w=800',
    rating: 4.8,
    dateStr: 'Best This Weekend',
    priceOrBudget: '₹3,500',
    tags: ['Nearby', 'Nature', 'Mountains', 'Road Trips'],
    description: 'Special AI Recommendation: Weather forecast predicts lush monsoon clouds over Munnar tea estates. Ideal time for cozy hill getaway.',
    organizerName: 'Travel Tribe AI',
    organizerAvatar: dummyMembers[1].avatarUrl,
    recommendationPrompt: '🌧️ Rainy Weekend Special',
  ),
  DiscoveryItem(
    id: 'disc_k3',
    title: 'Sunrise Kayaking in Alleppey Backwaters',
    subtitle: 'Navigate secret canals before tourists wake up',
    type: DiscoveryType.adventure,
    location: 'Alleppey, Kerala',
    cityTag: 'Kochi',
    imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&q=80&w=800',
    rating: 4.9,
    dateStr: 'Tomorrow, 5:30 AM',
    priceOrBudget: '₹1,200',
    attendeesCount: 18,
    tags: ['Nearby', 'Adventure', 'Nature', 'Water'],
    description: 'Paddle through silent backwater channels during golden morning hours. Includes authentic Kerala breakfast on a lotus farm.',
    organizerName: 'Kerala Kayak Tribe',
    organizerAvatar: dummyMembers[2].avatarUrl,
    difficulty: 'Easy',
    duration: '3 Hours',
  ),
];
