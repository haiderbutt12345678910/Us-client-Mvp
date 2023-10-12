import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/character_daily_votes_entity.dart';

class CharacterDailyVotesModel extends CharacterDailyVotesEntity {
  CharacterDailyVotesModel(
      {int? characterTotalDailyVotes,
      String? characterId,
      int? morningVotes,
      int? afternoonVotes,
      int? nightVotes})
      : super(
            characterTotalDailyVotes: characterTotalDailyVotes,
            characterId: characterId,
            afternoonVotes: afternoonVotes,
            morningVotes: morningVotes,
            nightVotes: nightVotes);

  factory CharacterDailyVotesModel.fromJson(Map<String, dynamic> json) {
    return CharacterDailyVotesModel(
        characterTotalDailyVotes: json['characterTotalDailyVotes'],
        afternoonVotes: json['afternoonVotes'],
        morningVotes: json['morningVotes'],
        characterId: json['characterId'],
        nightVotes: json['nightVotes']);
  }

  Map<String, dynamic> toJson() {
    return {
      'characterId': characterId,
      'afternoonVotes': afternoonVotes,
      'morningVotes': morningVotes,
      'nightVotes': nightVotes,
      'characterTotalDailyVotes': characterTotalDailyVotes
    };
  }
}
