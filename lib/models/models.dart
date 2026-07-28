export 'discovery_item.dart';

class Member {
  final String id;
  final String name;
  final String role; // 'Owner', 'Admin', 'Member'
  final String avatarUrl;

  Member({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });
}

class ChatMessage {
  final String id;
  final Member sender;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
  });
}

class Activity {
  final String id;
  final String title;
  final String location;
  final DateTime time;
  final String iconName;

  Activity({
    required this.id,
    required this.title,
    required this.location,
    required this.time,
    required this.iconName,
  });
}

class Photo {
  final String id;
  final String url;

  Photo({
    required this.id,
    required this.url,
  });
}

class Achievement {
  final String id;
  final String title;
  final String iconName;

  Achievement({
    required this.id,
    required this.title,
    required this.iconName,
  });
}

class BadgeItem {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final bool isEarned;

  BadgeItem({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.isEarned,
  });
}

class Destination {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final double rating;
  final double startingBudget;
  final String description;

  Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.rating,
    required this.startingBudget,
    required this.description,
  });
}

class Trip {
  final String id;
  final String destination;
  final String coverUrl;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;
  final String status;
  final bool isPublic;
  final bool isOwner;
  final String routeEndpoint; // e.g. 'Kochi ➔ Denpasar, Bali'
  final bool isOpenForMembers;
  final String? activeDay; // e.g. 'Day 3 of 7'
  final List<Member> members;
  final List<ChatMessage> chatMessages;
  final List<Activity> activities;
  final List<Photo> gallery;

  Trip({
    required this.id,
    required this.destination,
    required this.coverUrl,
    required this.startDate,
    required this.endDate,
    required this.budget,
    required this.status,
    this.isPublic = false,
    this.isOwner = false,
    this.routeEndpoint = 'Kochi ➔ Destination',
    this.isOpenForMembers = true,
    this.activeDay,
    required this.members,
    required this.chatMessages,
    required this.activities,
    required this.gallery,
  });
}
