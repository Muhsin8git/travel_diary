class Member {
  final String id;
  final String name;
  final String role; // 'Owner' or 'Member'
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

class Trip {
  final String id;
  final String destination;
  final String coverUrl;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;
  final String status;
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
    required this.members,
    required this.chatMessages,
    required this.activities,
    required this.gallery,
  });
}
