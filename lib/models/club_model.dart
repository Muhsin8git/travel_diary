import 'models.dart';

class ClubMemberContribution {
  final Member member;
  final double amountContributed;
  final double perShareGoal;
  final bool isPaid;
  final DateTime? contributionDate;

  ClubMemberContribution({
    required this.member,
    required this.amountContributed,
    required this.perShareGoal,
    required this.isPaid,
    this.contributionDate,
  });
}

class FundraiserPool {
  final String id;
  final String title;
  final double targetAmount;
  double raisedAmount;
  final double perMemberShare;
  final List<ClubMemberContribution> contributions;

  FundraiserPool({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.raisedAmount,
    required this.perMemberShare,
    required this.contributions,
  });
}

class TravelClub {
  final String id;
  final String name;
  final String genre; // e.g. 'Biker & Moto Club', 'Trekking & Backpacking'
  final bool isPrivate;
  final String coverUrl;
  final int memberCount;
  final String description;
  final String location;
  final List<Photo> sharedGallery;
  final FundraiserPool? activeFundraiser;
  final List<String> clubRules;
  final int friendsCount;

  TravelClub({
    required this.id,
    required this.name,
    required this.genre,
    required this.isPrivate,
    required this.coverUrl,
    required this.memberCount,
    required this.description,
    required this.location,
    required this.sharedGallery,
    this.activeFundraiser,
    required this.clubRules,
    this.friendsCount = 3,
  });
}
