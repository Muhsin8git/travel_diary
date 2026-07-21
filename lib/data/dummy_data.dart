import '../models/models.dart';

final List<Member> dummyMembers = [
  Member(
    id: 'm1',
    name: 'Ahmed',
    role: 'Owner',
    avatarUrl: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&q=80&w=100',
  ),
  Member(
    id: 'm2',
    name: 'Fatima',
    role: 'Member',
    avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100',
  ),
  Member(
    id: 'm3',
    name: 'Ali',
    role: 'Member',
    avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=100',
  ),
  Member(
    id: 'm4',
    name: 'Sarah',
    role: 'Member',
    avatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80&w=100',
  ),
];

final List<Achievement> dummyAchievements = [
  Achievement(id: 'a1', title: 'Globetrotter', iconName: 'globe'),
  Achievement(id: 'a2', title: 'Mountain Goat', iconName: 'mountain'),
  Achievement(id: 'a3', title: 'Beach Bum', iconName: 'umbrella'),
  Achievement(id: 'a4', title: 'Foodie', iconName: 'utensils'),
];

final List<Photo> dummyPhotos = [
  Photo(id: 'p1', url: 'https://images.unsplash.com/photo-1512100356356-de1b84283e18?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p2', url: 'https://images.unsplash.com/photo-1542332213-9b5a5a3fad35?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p3', url: 'https://images.unsplash.com/photo-1499856871958-5b9627545d1a?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p4', url: 'https://images.unsplash.com/photo-1506929562872-bb421503ef21?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p5', url: 'https://images.unsplash.com/photo-1534445867742-43195f401b6c?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p6', url: 'https://images.unsplash.com/photo-1528605248644-14dd04022da1?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p7', url: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p8', url: 'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p9', url: 'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p10', url: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p11', url: 'https://images.unsplash.com/photo-1533105079780-92b9be482077?auto=format&fit=crop&q=80&w=400'),
  Photo(id: 'p12', url: 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?auto=format&fit=crop&q=80&w=400'),
];

final List<Trip> dummyTrips = [
  Trip(
    id: 't1',
    destination: 'Bali Adventure',
    coverUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&q=80&w=800',
    startDate: DateTime.now().add(const Duration(days: 10)),
    endDate: DateTime.now().add(const Duration(days: 17)),
    budget: 1200.0,
    status: 'Upcoming',
    members: dummyMembers,
    chatMessages: [
      ChatMessage(id: 'c1', sender: dummyMembers[0], message: "Let's leave at 8 AM.", timestamp: DateTime.now().subtract(const Duration(minutes: 60))),
      ChatMessage(id: 'c2', sender: dummyMembers[1], message: "I'll book the hotel.", timestamp: DateTime.now().subtract(const Duration(minutes: 55))),
      ChatMessage(id: 'c3', sender: dummyMembers[2], message: "Don't forget the camera!", timestamp: DateTime.now().subtract(const Duration(minutes: 50))),
      ChatMessage(id: 'c4', sender: dummyMembers[3], message: "Got it!", timestamp: DateTime.now().subtract(const Duration(minutes: 45))),
      ChatMessage(id: 'c5', sender: dummyMembers[0], message: "Also, who is bringing the sunscreen?", timestamp: DateTime.now().subtract(const Duration(minutes: 40))),
      ChatMessage(id: 'c6', sender: dummyMembers[1], message: "I have two bottles, should be enough.", timestamp: DateTime.now().subtract(const Duration(minutes: 38))),
      ChatMessage(id: 'c7', sender: dummyMembers[2], message: "Awesome. Can't wait!", timestamp: DateTime.now().subtract(const Duration(minutes: 30))),
      ChatMessage(id: 'c8', sender: dummyMembers[3], message: "Have we decided on the beach club yet?", timestamp: DateTime.now().subtract(const Duration(minutes: 15))),
      ChatMessage(id: 'c9', sender: dummyMembers[0], message: "Potato Head seems good.", timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
      ChatMessage(id: 'c10', sender: dummyMembers[1], message: "Yes! Let's do that.", timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
    ],
    activities: [
      Activity(id: 'a1', title: 'Airport', location: 'Terminal 1', time: DateTime.now().copyWith(hour: 8, minute: 0), iconName: 'plane'),
      Activity(id: 'a2', title: 'Hotel Check-in', location: 'Resort', time: DateTime.now().copyWith(hour: 10, minute: 30), iconName: 'hotel'),
      Activity(id: 'a3', title: 'Lunch', location: 'Beach Cafe', time: DateTime.now().copyWith(hour: 13, minute: 0), iconName: 'utensils'),
      Activity(id: 'a4', title: 'Beach', location: 'Seminyak', time: DateTime.now().copyWith(hour: 17, minute: 0), iconName: 'umbrella'),
      Activity(id: 'a5', title: 'Dinner', location: 'Seafood Grill', time: DateTime.now().copyWith(hour: 20, minute: 0), iconName: 'utensils'),
    ],
    gallery: dummyPhotos.sublist(0, 4),
  ),
  Trip(
    id: 't2',
    destination: 'Manali Road Trip',
    coverUrl: 'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?auto=format&fit=crop&q=80&w=800',
    startDate: DateTime.now().add(const Duration(days: 30)),
    endDate: DateTime.now().add(const Duration(days: 35)),
    budget: 500.0,
    status: 'Planning',
    members: dummyMembers.sublist(0, 3),
    chatMessages: [
      ChatMessage(id: 'c1', sender: dummyMembers[0], message: "Are the bikes ready?", timestamp: DateTime.now().subtract(const Duration(days: 1))),
      ChatMessage(id: 'c2', sender: dummyMembers[2], message: "Getting them serviced today.", timestamp: DateTime.now().subtract(const Duration(hours: 12))),
    ],
    activities: [
      Activity(id: 'a1', title: 'Start Journey', location: 'Delhi', time: DateTime.now().copyWith(hour: 5, minute: 0), iconName: 'car'),
      Activity(id: 'a2', title: 'Breakfast', location: 'Highway Dhaba', time: DateTime.now().copyWith(hour: 8, minute: 30), iconName: 'coffee'),
    ],
    gallery: dummyPhotos.sublist(4, 8),
  ),
  Trip(
    id: 't3',
    destination: 'Dubai Vacation',
    coverUrl: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&q=80&w=800',
    startDate: DateTime.now().subtract(const Duration(days: 10)),
    endDate: DateTime.now().subtract(const Duration(days: 3)),
    budget: 2500.0,
    status: 'Completed',
    members: dummyMembers,
    chatMessages: [
      ChatMessage(id: 'c1', sender: dummyMembers[1], message: "That was an amazing trip!", timestamp: DateTime.now().subtract(const Duration(days: 2))),
    ],
    activities: [],
    gallery: dummyPhotos.sublist(8, 12),
  ),
];
