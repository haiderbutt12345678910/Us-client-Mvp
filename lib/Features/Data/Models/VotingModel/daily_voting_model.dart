import 'package:flutter_application_assignmnettechnilify/Features/Data/Models/VotingModel/character_daily_votes.dart';
import 'package:flutter_application_assignmnettechnilify/Features/Domain/Entities/VotingEntity/character_daily_votes_entity.dart';
import '../../../Domain/Entities/VotingEntity/daily_votes_entity.dart';

class DailyVotesModel extends DailyVotesEntity {
  DailyVotesModel({
    int? totalVotes,
    String? date,
    List<CharacterDailyVotesEntity>? charactersDailyVotesList,
  }) : super(
          date: date,
          totalVotes: totalVotes,
          charactersDailyVotesList: charactersDailyVotesList,
        );

  factory DailyVotesModel.fromJson(Map<String, dynamic> json) {
    List<CharacterDailyVotesModel> convertedDailyVotesList = [];
    if (json['charactersDailyVotesList'] != null) {
      for (var characterJson in json['charactersDailyVotesList']) {
        convertedDailyVotesList
            .add(CharacterDailyVotesModel.fromJson(characterJson));
      }
    }

    return DailyVotesModel(
      date: json['date'],
      totalVotes: json['totalVotes'],
      charactersDailyVotesList: convertedDailyVotesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'totalVotes': totalVotes,
      'charactersDailyVotesList': charactersDailyVotesList!
          .map((character) => CharacterDailyVotesModel(
                  characterId: character.characterId,
                  afternoonVotes: character.afternoonVotes,
                  morningVotes: character.morningVotes,
                  nightVotes: character.nightVotes,
                  characterTotalDailyVotes: character.characterTotalDailyVotes)
              .toJson())
          .toList(),
    };
  }
}
