import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/character_daily_votes_entity.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/character_entity.dart';

class VoteModelChracter {
  CharacterDailyVotesEntity characterDailyVotesEntity;
  CharacterEntity characterEntity;
  String? date;
  VoteModelChracter(
      {required this.characterDailyVotesEntity,
      required this.characterEntity,
      this.date});
}
