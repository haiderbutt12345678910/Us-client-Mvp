import 'character_daily_votes_entity.dart';

class DailyVotesEntity {
  int? totalVotes;
  String? date;
  List<CharacterDailyVotesEntity>? charactersDailyVotesList;

  DailyVotesEntity({this.totalVotes, this.charactersDailyVotesList, this.date});
}
